import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;
  const ExamDetailScreen({required this.exam, super.key});

  String _getTimeRemaining(DateTime examDate) {
    final now = DateTime.now();
    final difference = examDate.difference(now);

    if (difference.isNegative) {
      return 'Испитот е поминат.';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24; 
    return '$days дена, $hours часа';
  }

  @override
  Widget build(BuildContext context) {
    final String timeRemaining = _getTimeRemaining(exam.dateTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали за испит'),
        backgroundColor: exam.isPassed ? Colors.grey : Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.subjectName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),

            Card(
              color: exam.isPassed ? Colors.red.shade100 : Colors.green.shade100,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      exam.isPassed ? Icons.check_circle_outline : Icons.schedule,
                      color: exam.isPassed ? Colors.red.shade700 : Colors.green.shade700,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      exam.isPassed ? 'Статус: Поминат' : 'Време преостанато:',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    Text(
                      timeRemaining,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: exam.isPassed ? Colors.red.shade700 : Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildDetailRow(
              icon: Icons.date_range,
              title: 'Датум',
              value: DateFormat('EEEE, dd MMMM yyyy', 'mk').format(exam.dateTime),
            ),
            _buildDetailRow(
              icon: Icons.access_time_filled,
              title: 'Време',
              value: DateFormat('HH:mm').format(exam.dateTime),
            ),
            
            const Divider(height: 30),

            const Text(
              'Простории за одржување:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...exam.classrooms.map((room) => Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              child: _buildDetailRow(
                icon: Icons.meeting_room,
                title: room,
                value: '',
                isList: true,
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String title, required String value, bool isList = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blue.shade700),
          const SizedBox(width: 15),
          isList
              ? Expanded(child: Text(title, style: const TextStyle(fontSize: 16)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}