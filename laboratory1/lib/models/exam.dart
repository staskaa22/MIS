class Exam {
  final String subjectName;
  final DateTime dateTime;
  final List<String> classrooms;

  const Exam({
    required this.subjectName,
    required this.dateTime,
    required this.classrooms,
  });

  bool get isPassed {
    final now = DateTime.now();
    return dateTime.isBefore(now);
  }
}