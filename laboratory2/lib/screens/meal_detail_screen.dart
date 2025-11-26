// lib/screens/meal_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail.dart';
import '../services/api_service.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;
  final bool isRandom;

  const MealDetailScreen({super.key, required this.mealId, this.isRandom = false});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Може да додадете Snackbar или дијалог за грешка
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(title: Text(isRandom ? 'Рандом рецепт' : 'Детален рецепт')),
      body: FutureBuilder<MealDetail>(
        future: apiService.fetchMealDetail(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // <--- ДОПОЛНЕТО
          } else if (snapshot.hasError) {
            return Center(child: Text('Грешка при вчитување: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Слика
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      meal.strMealThumb,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Име
                  Text(meal.strMeal, style: Theme.of(context).textTheme.headlineMedium),
                  const Divider(),

                  // Инструкции
                  const Text('Инструкции:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(meal.strInstructions),
                  const SizedBox(height: 20),

                  // Состојки и мерки
                  const Text('Состојки:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: meal.ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text('${meal.measures[index]} ${meal.ingredients[index]}'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // YouTube Линк
                  if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.play_circle_fill),
                        label: const Text('Гледајте на YouTube'),
                        onPressed: () => _launchUrl(meal.strYoutube!),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
          return const Center(child: Text('Нема достапен рецепт.'));
        },
      ),
    );
  }
}