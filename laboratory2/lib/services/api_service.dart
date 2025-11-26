import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // 1. Листа на категории
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // 2. Јадења по категорија
  Future<List<Meal>> fetchMealsByCategory(String categoryName) async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=$categoryName'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // API враќа 'null' ако нема јадења, проверете го тоа.
      if (data['meals'] == null) return []; 
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load meals for category $categoryName');
    }
  }

  // 3. Детален рецепт
  Future<MealDetail> fetchMealDetail(String mealId) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$mealId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal detail for ID $mealId');
    }
  }
  
  // 4. Рандом рецепт
  Future<MealDetail> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MealDetail.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load random meal');
    }
  }

  // 5. Пребарување на јадења
  Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$_baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List)
          .map((json) => Meal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }
}