import 'package:cloud_firestore/cloud_firestore.dart';
import 'factoryController.dart';

class StoreController {
  final firestore = FirebaseFirestore.instance;
  CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');

  // add ingredients that are not already present in the store
  // for ingredients that are already present in store, just update the quantity (not increase)
  Future addIngredients(List<Map> ingredientsToAdd, String uid) async {
    WriteBatch batch = firestore.batch();
    await Future.forEach(ingredientsToAdd, (data) async {
      // print(element.runtimeType);
      // Map<String, dynamic> data =
      //     element.map((key, value) => MapEntry(key.toString(), value));
      final ingredient = await ingredients
          .where("userID", isEqualTo: uid)
          .where("name", isEqualTo: data["name"])
          .get();

      if (ingredient.docs.isEmpty) {
        data["userID"] = uid;

        final newDocRef = ingredients.doc();
        batch.set(newDocRef, data);
      } else {
        batch.update(
            ingredient.docs[0].reference, data as Map<String, dynamic>);
      }
    });
    try {
      var res = await batch.commit();
      return "success";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // update ingredient information. (expiry date or qty). pass it as a map with new details and indredient id.
  Future<String> updateIngredient(
      {required String ingredientId, required Map ingredientDetails}) async {
    return FactoryController()
        .update(ingredientId, ingredientDetails, ingredients);
  }

  // delete an ingredient from store
  Future<String> deleteIngredient(String ingredientID) async {
    return FactoryController().delete(ingredientID, ingredients);
  }
}
