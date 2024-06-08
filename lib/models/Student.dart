// lib/student.dart
class Student {
  String name;
  int rollNumber;
  int classNumber;
  String division;

  Student({
    required this.name,
    required this.rollNumber,
    required this.classNumber,
    required this.division,
  });

  // Method to convert Student object to Map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNumber': rollNumber,
      'classNumber': classNumber,
      'division': division,
    };
  }

  // Method to create Student object from Map (for retrieving from database)
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      rollNumber: map['rollNumber'],
      classNumber: map['classNumber'],
      division: map['division'],
    );
  }
}
