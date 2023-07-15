import 'package:cloud_firestore/cloud_firestore.dart';

class Ingredient {
  final String name;
  final int quantity;
  final String metric;
  final DateTime expiryDate;
  final String userID;
  final String ingredientID;
  static CollectionReference ingredients =
      FirebaseFirestore.instance.collection('ingredients');

  Ingredient(
      {required this.name,
      required this.userID,
      required this.expiryDate,
      required this.quantity,
      required this.metric,
      required this.ingredientID});
  factory Ingredient.createIngredientFromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    // print(data);

    // if (data == null) return null;
    var x = Ingredient(
        name: data["name"] ?? "",
        quantity: data["quantity"] ?? 0,
        metric: data["metric"] ?? "items",
        expiryDate:
            (data["expiryDate"] != null) ? data["expiryDate"].toDate() : "null",
        userID: data["userID"] ?? '',
        ingredientID: doc.id);

    return x;
  }

  static Stream<List<dynamic>> getStore(String uid) {
    return ingredients
        .where('userID', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // print("printing doc");

        return Ingredient.createIngredientFromFirestore(doc);
      }).toList();
    });
  }
}
