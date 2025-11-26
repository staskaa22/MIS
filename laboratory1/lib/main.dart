import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/screens/exam_list_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
Future<void> main() async {
  await initializeDateFormatting(null, null); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamListScreen(indexNumber: '221076'), 
    );
  }
}
@override
Widget build(BuildContext context) {
  return MaterialApp(
   
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', 'US'), 
      Locale('mk', 'MK'), 
    ],
  );
}
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Распоред за испити',
      
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //       useMaterial3: true, 
  //     ),
  //     localizationsDelegates: const [
  //       GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate,
  //       GlobalCupertinoLocalizations.delegate,
  //     ],
  //     supportedLocales: const [
  //       Locale('en', 'US'), 
  //       Locale('mk', 'MK'), 
  //     ],

  //     home: const ExamListScreen(indexNumber: '221076'), 
  //   );
  // }
