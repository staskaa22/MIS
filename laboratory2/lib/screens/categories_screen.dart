// lib/screens/categories_screen.dart
import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../widgets/category_card.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Category>> _categoriesFuture;
  List<Category> _allCategories = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _fetchCategories();
  }

  // Вчитување на категориите и зачувување на оригиналната листа
  Future<List<Category>> _fetchCategories() async {
    final categories = await _apiService.fetchCategories();
    _allCategories = categories;
    return categories;
  }

  // Филтрирање на листата врз основа на пребарувањето
  List<Category> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _allCategories;
    }
    return _allCategories.where((category) {
      return category.strCategory.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  // Приказ на рандом рецепт
  void _fetchAndShowRandomMeal() async {
    // Приказ на Loading
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Вчитување на рандом рецепт...')),
    );

    try {
      final mealDetail = await _apiService.fetchRandomMeal();
      // Навигација до детален приказ
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MealDetailScreen(
              mealId: mealDetail.idMeal,
              isRandom: true,
            ),
          ),
        );
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Грешка при вчитување: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👨‍🍳 Книгa со Рецепти'),
        actions: [
          // Копче за Рандом Рецепт на Денот
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Рандом Рецепт на Денот',
            onPressed: _fetchAndShowRandomMeal,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Поле за пребарување на категории
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Пребарај категории',
                hintText: 'Внесете име на категорија...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Листа на Категории
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: _categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                } else if (!snapshot.hasData || _allCategories.isEmpty) {
                  return const Center(child: Text('Нема пронајдени категории.'));
                }

                final displayCategories = _filteredCategories;

                if (displayCategories.isEmpty) {
                    return const Center(child: Text('Нема пронајдени категории според пребарувањето.'));
                }

                return ListView.builder(
                  itemCount: displayCategories.length,
                  itemBuilder: (ctx, index) {
                    return CategoryCard(category: displayCategories[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}