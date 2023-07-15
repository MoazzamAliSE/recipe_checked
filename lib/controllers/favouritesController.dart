import 'package:cloud_firestore/cloud_firestore.dart';
import "factoryController.dart";

class FavouritesController {
  final firestore = FirebaseFirestore.instance;
  CollectionReference favRecipes =
      FirebaseFirestore.instance.collection('favRecipes');

  Future<bool> isFavourite(int recipeID, String uid) async {
    var favourite = await favRecipes
        .where("userID", isEqualTo: uid)
        .where("recipeID", isEqualTo: recipeID)
        .get();

    if (favourite.docs.isEmpty) {
      return false;
    }
    return true;
  }

  // add a favourite recipe, added only if fav recipe not alr in recipes
  Future addFavourite(int recipeID, String recipeName, String uid) async {
    // check whether the recipe id alr exists in users favourites
    var favourite = await favRecipes
        .where("userID", isEqualTo: uid)
        .where("recipeID", isEqualTo: recipeID)
        .get();
    if (favourite.docs.isNotEmpty) {
      return "Recipe already in favourites";
    }

    // add favourites to database if it doest exist
    try {
      final docRef = await favRecipes
          .add({"recipeID": recipeID, "userID": uid, "title": recipeName});
      return "success";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // delete favourite recipe by id
  Future<String> deleteFavourite(String favRecipeID) async {
    return FactoryController().delete(favRecipeID, favRecipes);
  }
}
