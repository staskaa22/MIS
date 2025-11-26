import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:flutter_application_1/models/exam.dart';
import 'package:flutter_application_1/screens/exam_detail_screen.dart'; 

class ExamCard extends StatelessWidget {
  final Exam exam;
  
  const ExamCard({required this.exam, super.key});

  @override
  Widget build(BuildContext context) {
    final Color cardColor = exam.isPassed ? Colors.grey.shade200 : Colors.blue.shade50;
    final Color textColor = exam.isPassed ? Colors.grey.shade700 : Colors.black;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: cardColor,
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExamDetailScreen(exam: exam),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.subjectName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: textColor),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('dd.MM.yyyy').format(exam.dateTime),
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(width: 20),
                  Icon(Icons.access_time, size: 16, color: textColor),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('HH:mm').format(exam.dateTime),
                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 16, color: textColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      exam.classrooms.join(', '), 
                      style: TextStyle(fontStyle: FontStyle.italic, color: textColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}