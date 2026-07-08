import 'package:flutter_test/flutter_test.dart';
import 'package:student_records/student.dart';

void main() {
  test('Student converts to and from a database map', () {
    const student = Student(
      id: 1,
      indexNo: 'GCTU001',
      fullName: 'Ama Mensah',
      programme: 'BSc Computer Science',
      level: 300,
      email: 'ama@example.com',
    );

    final copy = Student.fromMap(student.toMap());

    expect(copy.indexNo, 'GCTU001');
    expect(copy.fullName, 'Ama Mensah');
    expect(copy.level, 300);
    expect(copy.email, 'ama@example.com');
  });
}
