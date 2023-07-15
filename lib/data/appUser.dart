import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_checked/controllers/authenticationController.dart';

class AppUser {
  final String uid;
  final String email;
  final String displayName;
  static final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  AppUser({required this.email, required this.displayName, required this.uid});

  // factory AppUser.createAppuserFromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map;
  //   AppUser x = AppUser(
  //       displayName: data['displayName'] ?? '',
  //       email: data['email'] ?? '',
  //       uid: doc.id);
  //   return x;
  // }
  factory AppUser.createAppuserFromFirestore(DocumentSnapshot doc) {
    Map? data = doc.data() as Map?;
    AppUser x = AppUser(
      displayName: data?['displayName'] ?? '',
      email: data?['email'] ?? '',
      uid: doc.id,
    );
    return x;
  }

  static Stream<AppUser>? getUserFromID(docID) {
    if (docID == null) {
      return null;
    } else {
      return _users.doc(docID).snapshots().map((doc) {
        return AppUser.createAppuserFromFirestore(doc);
      });
    }
  }

  static Stream<AppUser>? getCurrentUser() {
    User? currUser = AuthenticationController().getCurrUserFromFirebase();
    return (currUser == null) ? null : getUserFromID(currUser.uid);
  }

  // Define a default user constructor or method
  factory AppUser.defaultUser() {
    return AppUser(
      displayName: 'Unknown',
      email: '',
      uid: '',
    );
  }
}
