class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strInstructions;
  final String strMealThumb;
  final String? strYoutube;
  final List<String> ingredients;
  final List<String> measures;

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    required this.strInstructions,
    required this.strMealThumb,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    // Функција за извлекување на состојки и мерки (Ingredient/Measure up to 20)
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'] ?? '';
      String measure = json['strMeasure$i'] ?? '';

      if (ingredient.isNotEmpty && ingredient.trim().isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure);
      }
    }

    return MealDetail(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? 'Unknown Meal',
      strInstructions: json['strInstructions'] ?? 'No instructions available.',
      strMealThumb: json['strMealThumb'] ?? '',
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}