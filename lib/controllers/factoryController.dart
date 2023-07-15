import 'package:cloud_firestore/cloud_firestore.dart';

class FactoryController {
  Future<String> update(
      String docID, Map docDetails, CollectionReference collection) async {
    Map<String, dynamic> data =
        docDetails.map((key, value) => MapEntry(key.toString(), value));
    try {
      await collection.doc(docID).update(data);
      return "success";
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }

  Future<String> delete(String docID, CollectionReference collection) async {
    try {
      await collection.doc(docID).delete();
      return "success";
    } catch (e) {
      print(e.toString());
      return (e.toString());
    }
  }
}
