class Student {
  final int? id;
  final String indexNo;
  final String fullName;
  final String programme;
  final int level;
  final String email;

  const Student({
    this.id,
    required this.indexNo,
    required this.fullName,
    required this.programme,
    required this.level,
    required this.email,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'indexNo': indexNo,
    'fullName': fullName,
    'programme': programme,
    'level': level,
    'email': email,
  };

  factory Student.fromMap(Map<String, dynamic> map) => Student(
    id: map['id'] as int?,
    indexNo: map['indexNo'] as String,
    fullName: map['fullName'] as String,
    programme: map['programme'] as String,
    level: map['level'] as int,
    email: (map['email'] as String?) ?? '',
  );
}
