import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_checked/controllers/favouritesController.dart';
import 'package:recipe_checked/data/recipe.dart';

class RecipeController {
  List<String> keys = [
    "fdaee5a82b29439689e4bda0644cc60f",
    "8f75676c728a4e7ebac546f628cb0dfa",
    "b9149f327a5642eeba443e957f4f1b23"
  ];

  Future generateRecipes(List<String> ingredients) async {
    // String key = keys[keyId];
    // var url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
    //   "apiKey": key,
    //   "ingredients": ingredients.join(","),
    //   "number": "1",
    //   "sort": "max-used-ingredients"
    // });
    // var response = await http.get(url);
    var res = [];
    var res1 = {};
    var res2 = {};
    var res3 = {};
    var res4 = {};
    var res5 = {};
    res1["id"] = 640185;
    res1["title"] = "Cottage pie with Quorn mince";
    res2["id"] = 636962;
    res2["title"] = "Caprese Quick Bread";
    res3["id"] = 636769;
    res3["title"] = "Mini Ham Omelets";
    res4["id"] = 659459;
    res4["title"] = "Savory Carrot Souffle";
    res5["id"] = 640064;
    res5["title"] = "Coriander Ravioli With Pumpkin & Cottage Cheese Filling";
    res.add(res1);
    res.add(res2);
    res.add(res3);
    res.add(res4);
    res.add(res5);
    for (var i = 0; i < res.length; i++) {
      bool isFav = await FavouritesController()
          .isFavourite(res[i]["id"], FirebaseAuth.instance.currentUser!.uid);
      res[i]["isFavourite"] = isFav;
      // print(res[i]["id"]);
      // print(res[i]["title"]);
      // print(res[i]["isFavourite"]);
    }
    return res;
    // if (response.statusCode == 200) {
    //   String data = response.body;
    //   // print(data);
    //   var res = jsonDecode(data);
    //   for (var i = 0; i < res.length; i++) {
    //     bool isFav = await FavouritesController()
    //         .isFavourite(res[i]["id"], FirebaseAuth.instance.currentUser.uid);
    //     res[i]["isFavourite"] = isFav;
    //     print(res[i]["id"]);
    //     print(res[i]["title"]);
    //     print(res[i]["isFavourite"]);
    //   }
    //
    //   // print(res[5]["isFavourite"]);
    //   return res;
    // } else {
    //   print(response.statusCode);
    //   if (response.statusCode == 402) {
    //     return generateRecipes(ingredients, keyId: (keyId + 1) % 3);
    //   }
    // }
  }
  // generates recipes. pass in a list of ingredients. returns a json object with the recipes (curently returns 10)
  // Future generateRecipes(List<String> ingredients, {int keyId = 0}) async {
  //   String key = keys[keyId];
  //   var url = Uri.https('api.spoonacular.com', '/recipes/findByIngredients', {
  //     "apiKey": key,
  //     "ingredients": ingredients.join(","),
  //     "number": "5",
  //     "sort": "max-used-ingredients"
  //   });
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     // print(data);
  //     var res = jsonDecode(data);
  //     for (var i = 0; i < res.length; i++) {
  //       bool isFav = await FavouritesController()
  //           .isFavourite(res[i]["id"], FirebaseAuth.instance.currentUser.uid);
  //       res[i]["isFavourite"] = isFav;
  //       print(res[i]["id"]);
  //       print(res[i]["title"]);
  //       print(res[i]["isFavourite"]);
  //     }
  //
  //     // print(res[5]["isFavourite"]);
  //     return res;
  //   } else {
  //     print(response.statusCode);
  //     if (response.statusCode == 402) {
  //       return generateRecipes(ingredients, keyId: (keyId + 1) % 3);
  //     }
  //   }
  // }

  // get recipe details by passing in recipe id. returns a Recipe class instance.
  Future getRecipe(String id, {int keyId = 0}) async {
    // print(key);
    // if (key == null) {
    //   key = "fdaee5a82b29439689e4bda0644cc60f";
    // }
    String key = keys[keyId];
    var url = Uri.https('api.spoonacular.com', '/recipes/$id/information', {
      "apiKey": key,
      "includeNutrition": "true",
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> res = jsonDecode(data);

      Recipe x = Recipe.createRecipeFromRes(res);

      return x;
    } else {
      print(response.statusCode);
      if (response.statusCode == 402) {
        return getRecipe(id, keyId: (keyId + 1) % 3);
      }
    }
  }
}
