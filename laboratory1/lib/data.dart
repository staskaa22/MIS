import 'package:flutter_application_1/models/exam.dart';

List<Exam> get hardcodedExams {
  final now = DateTime.now();

  List<Exam> exams = [
    Exam(
      subjectName: 'Вештачка Интелигенција',
      dateTime: now.subtract(const Duration(days: 15, hours: 3)), 
      classrooms: ['Амфитеатар Машински', 'Лабораторија 215'],
    ),
    Exam(
      subjectName: 'Компјутерски Мрежи',
      dateTime: now.subtract(const Duration(days: 7, hours: 1)), 
      classrooms: ['Лабораторија 117'],
    ),
    Exam(
      subjectName: 'Објектно Ориентирано Програмирање',
      dateTime: now.subtract(const Duration(days: 3, hours: 15)), 
      classrooms: ['Лабораторија 138'],
    ),
    
    Exam(
      subjectName: 'Математика 1',
      dateTime: now.add(const Duration(days: 2, hours: 10, minutes: 30)), 
      classrooms: ['Амфитеатар 1'],
    ),
    Exam(
      subjectName: 'Бази на Податоци',
      dateTime: now.add(const Duration(days: 5, hours: 9)), 
      classrooms: ['Лабораторија 200АБ', 'Лабораторија 215'],
    ),
    Exam(
      subjectName: 'Дискретна Математика',
      dateTime: now.add(const Duration(days: 8, hours: 13, minutes: 45)), 
      classrooms: ['Амфитеатар Машински'],
    ),
    Exam(
      subjectName: 'Оперативни Системи',
      dateTime: now.add(const Duration(days: 12, hours: 11)), 
      classrooms: ['Лабораторија 215'],
    ),
    Exam(
      subjectName: 'Алгоритми и Податочни Структури',
      dateTime: now.add(const Duration(days: 18, hours: 10)), 
      classrooms: ['Лабораторија 200АБ'],
    ),
    Exam(
      subjectName: 'Професионални Вештини',
      dateTime: now.add(const Duration(days: 25, hours: 14)), 
      classrooms: ['Онлајн'],
    ),
    Exam(
      subjectName: 'Напредно Програмирање',
      dateTime: now.add(const Duration(days: 30, hours: 9, minutes: 15)),
      classrooms: ['Лабораторија 12'],
    ),
  ];
  exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

  return exams;
}