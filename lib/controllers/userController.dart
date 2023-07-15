import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_checked/controllers/authenticationController.dart';

class UserController {
  final String uid;

  UserController({required this.uid});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  AuthenticationController authController = AuthenticationController();

  Future<dynamic> createUser(
      String displayName, String email, String uid) async {
    try {
      Map<String, dynamic> data = {};

      // if (users.doc(uid) != null) {
      //   print('User already exists');
      //   return;
      // } else {
      data['displayName'] = displayName;
      data['email'] = email;
      data['uid'] = uid;
      await users.doc(uid).set(data);
      print('Successfully added user');
      return;
    } catch (e) {
      print('Error in adding user');
      print(e.toString());
      return null;
    }
  }

  /*Future printDocumentRef(String uid, String email) async {
    QuerySnapshot querySnapshot = await users.get();
    dynamic allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i=0; i<allData.length; i++)
    {
      if (allData[i]['email'] == email) {
        print('Login User Information: ');
        print(allData[i]);
      }
    }
  }*/
}
