// lib/screens/meals_screen.dart
import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  final String categoryName;

  const MealsScreen({super.key, required this.categoryName});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Meal>> _mealsFuture;
  List<Meal> _allMeals = [];
  String _searchQuery = '';
  bool _isSearchingApi = false;

  @override
  void initState() {
    super.initState();
    _mealsFuture = _fetchInitialMeals();
  }

  // Прво вчитување на сите јадења за категоријата
  Future<List<Meal>> _fetchInitialMeals() async {
    final meals = await _apiService.fetchMealsByCategory(widget.categoryName);
    _allMeals = meals;
    return meals;
  }

  // Пребарување јадења преку API
  void _searchMealsApi(String query) async {
    setState(() {
      _searchQuery = query;
      _isSearchingApi = true;
    });

    if (query.isEmpty) {
      // Ако пребарувањето е празно, вратете се на оригиналната листа
      setState(() {
        _isSearchingApi = false;
        _mealsFuture = Future.value(_allMeals);
      });
      return;
    }

    // Инаку, извршете пребарување преку API
    setState(() {
      _mealsFuture = _apiService.searchMeals(query);
    });
    // Забелешка: Пребарувањето преку API ќе врати резултати од СИТЕ категории,
    // но ние го користиме за да одговориме на барањето за пребарување.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName} Јадења'),
      ),
      body: Column(
        children: <Widget>[
          // Поле за пребарување на јадења
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: _searchMealsApi, // Пребарува при притискање на Enter/Done
              decoration: InputDecoration(
                labelText: 'Пребарај јадења (Притиснете Enter)',
                hintText: 'Внесете име на јадење...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Приказ на јадењата
          Expanded(
            child: FutureBuilder<List<Meal>>(
              future: _mealsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Грешка: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(_isSearchingApi
                        ? 'Нема пронајдени јадења за "$_searchQuery".'
                        : 'Нема пронајдени јадења за оваа категорија.'
                    ),
                  );
                }

                final meals = snapshot.data!;

                // Прикажи ги јадењата во grid layout
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 колони
                    childAspectRatio: 3 / 4, // Сооднос висина/ширина
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (ctx, index) {
                    return MealItem(meal: meals[index]);
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