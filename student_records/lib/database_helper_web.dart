import 'dart:convert';
import 'dart:html' as html;

import 'student.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static const _storageKey = 'student_records_web_rows';

  // Keeps main.dart's startup check platform-neutral. Mobile returns SQLite;
  // web warms the local browser store and then uses the same CRUD methods.
  Future<DatabaseHelper> get database async => this;

  Future<int> insertStudent(Student student) async {
    final students = await allStudents();
    final nextId = student.id ?? _nextId(students);
    final saved = Student(
      id: nextId,
      indexNo: student.indexNo,
      fullName: student.fullName,
      programme: student.programme,
      level: student.level,
      email: student.email,
    );

    students.removeWhere((item) => item.indexNo == saved.indexNo);
    students.add(saved);
    _save(students);
    return nextId;
  }

  Future<List<Student>> allStudents() async {
    final raw = html.window.localStorage[_storageKey];
    if (raw == null || raw.isEmpty) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    final students =
        decoded
            .map(
              (item) => Student.fromMap(Map<String, dynamic>.from(item as Map)),
            )
            .toList()
          ..sort((a, b) => a.fullName.compareTo(b.fullName));
    return students;
  }

  Future<List<Student>> searchStudents(String term) async {
    final cleanTerm = term.trim().toLowerCase();
    final students = await allStudents();
    if (cleanTerm.isEmpty) return students;

    return students.where((student) {
      return student.fullName.toLowerCase().contains(cleanTerm) ||
          student.indexNo.toLowerCase().contains(cleanTerm) ||
          student.programme.toLowerCase().contains(cleanTerm);
    }).toList();
  }

  Future<int> updateStudent(Student student) async {
    final students = await allStudents();
    final index = students.indexWhere((item) => item.id == student.id);
    if (index == -1) return 0;

    students[index] = student;
    _save(students);
    return 1;
  }

  Future<int> deleteStudent(int id) async {
    final students = await allStudents();
    final before = students.length;
    students.removeWhere((student) => student.id == id);
    _save(students);
    return before - students.length;
  }

  Future<Map<int, int>> levelCounts() async {
    final counts = <int, int>{};
    for (final student in await allStudents()) {
      counts[student.level] = (counts[student.level] ?? 0) + 1;
    }
    return Map.fromEntries(
      counts.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  int _nextId(List<Student> students) {
    if (students.isEmpty) return 1;
    return students
            .map((student) => student.id ?? 0)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }

  void _save(List<Student> students) {
    html.window.localStorage[_storageKey] = jsonEncode(
      students.map((student) => student.toMap()).toList(),
    );
  }
}
