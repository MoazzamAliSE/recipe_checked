class Recipe {
  final int id;
  final bool vegetarian;
  final bool vegan;
  final bool glutenFree;
  final bool dairyFree;
  final int preparationMinutes;
  final int cookingMinutes;
  final int readyInMinutes;
  final int servings;
  final List<dynamic> ingredients;
  final String title;
  final String image;
  final String imageType;
  final List<dynamic> nutrients;
  final String summary;
  final String instructions;
  // the summary and instructions gotta remove the line breaks etc.

  Recipe(
      {required this.vegetarian,
      required this.image,
      required this.id,
      required this.title,
      required this.cookingMinutes,
      required this.dairyFree,
      required this.glutenFree,
      required this.imageType,
      required this.ingredients,
      required this.instructions,
      required this.nutrients,
      required this.preparationMinutes,
      required this.readyInMinutes,
      required this.servings,
      required this.summary,
      required this.vegan});

  factory Recipe.createRecipeFromRes(Map<String, dynamic> res) {
    Recipe x = Recipe(
      vegetarian: res['vegetarian'],
      vegan: res['vegan'],
      glutenFree: res['glutenFree'],
      dairyFree: res['dairyFree'],
      id: res['id'],
      title: res['title'],
      preparationMinutes: res["preparationMinutes"],
      cookingMinutes: res["cookingMinutes"],
      readyInMinutes: res['readyInMinutes'],
      servings: res['servings'],
      image: res['image'],
      imageType: res['imageType'],
      nutrients: res['nutrition']['nutrients'] ?? [],
      ingredients: res['extendedIngredients']
              .map((ingredient) => ingredient["original"])
              .toList() ??
          [],
      summary: res['summary'],
      instructions: res['instructions'],
    );
    return x;
  }
}
