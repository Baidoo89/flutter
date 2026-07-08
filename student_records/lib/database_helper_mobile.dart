import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'student.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _db;

  Future<Database> get database async {
    _db ??= await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'student_records.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            indexNo TEXT NOT NULL UNIQUE,
            fullName TEXT NOT NULL,
            programme TEXT NOT NULL,
            level INTEGER NOT NULL,
            email TEXT NOT NULL DEFAULT ''
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Version 2 adds email without deleting existing student records.
        if (oldVersion < 2) {
          await db.execute(
            "ALTER TABLE students ADD COLUMN email TEXT NOT NULL DEFAULT ''",
          );
        }
      },
    );
  }

  Future<int> insertStudent(Student student) async {
    final db = await database;
    return db.insert(
      'students',
      student.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Student>> allStudents() async {
    final db = await database;
    final rows = await db.query('students', orderBy: 'fullName ASC');
    return rows.map(Student.fromMap).toList();
  }

  Future<List<Student>> searchStudents(String term) async {
    final db = await database;
    final cleanTerm = term.trim();
    if (cleanTerm.isEmpty) return allStudents();

    final rows = await db.query(
      'students',
      where: 'fullName LIKE ? OR indexNo LIKE ? OR programme LIKE ?',
      whereArgs: ['%$cleanTerm%', '%$cleanTerm%', '%$cleanTerm%'],
      orderBy: 'fullName ASC',
    );
    return rows.map(Student.fromMap).toList();
  }

  Future<int> updateStudent(Student student) async {
    final db = await database;
    return db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  Future<Map<int, int>> levelCounts() async {
    final db = await database;
    final rows = await db.rawQuery(
      'SELECT level, COUNT(*) AS n FROM students GROUP BY level ORDER BY level ASC',
    );
    return {for (final row in rows) row['level'] as int: row['n'] as int};
  }
}
