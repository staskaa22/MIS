import 'package:flutter/material.dart';
import 'package:flutter_application_1/data.dart';
import 'package:flutter_application_1/models/exam.dart';
import 'package:flutter_application_1/widgets/exam_card.dart'; 

class ExamListScreen extends StatelessWidget {
  final String indexNumber;
  const ExamListScreen({required this.indexNumber, super.key});

  @override
  Widget build(BuildContext context) {
    final List<Exam> exams = hardcodedExams;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Распоред за испити - $indexNumber'),
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return ExamCard(exam: exam);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                label: Text(
                  'Вкупно испити: ${exams.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.blue.shade100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}