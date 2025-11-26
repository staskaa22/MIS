// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/categories_screen.dart'; // <--- ВАЖНО: Увезете го вашиот екран

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheMealDB Recipes',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      // ОВА Е ПОЧЕТНИОТ ЕКРАН НА АПЛИКАЦИЈАТА ЗА РЕЦЕПТИ
      home: const CategoriesScreen(), 
    );
  }
}