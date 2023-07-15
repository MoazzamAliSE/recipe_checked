import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_checked/controllers/userController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  User? getCurrUserFromFirebase() {
    try {
      return _auth.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrUserFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await users.get();
      dynamic allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      for (var i = 0; i < allData.length; i++) {
        if (allData[i]['uid'] == _auth.currentUser!.uid) {
          print('Login User Information: ');
          print(allData[i]);
          return allData[i]['displayName'];
        }
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return 'Pass';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('The Password is wrong.');
        return 'WrongPassword';
      } else if (e.code == 'invalid-email') {
        print('The email address is badly formatted.');
        return 'InvalidEmail';
      } else if (e.code == 'user-not-found') {
        print(
            'There is no user record corresponding to this identifier. User may have been deleted.');
        return 'Usernotfound';
      } else if (e.code == 'too-many-requests') {
        print('There has been too many attempts made. Please try again later.');
        return 'ExceedAttempts';
      } else {
        print(e.toString());
        return 'GenericError';
      }
    }
  }

  Future forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "success";
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future checkSamePassword(String password, String confirmPassword) async {
    try {
      if (password == confirmPassword) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  Future<dynamic> registerWithEmailAndPassword(
      String displayName, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await user!.sendEmailVerification();

      // create a new doc for the user with new id
      UserController(uid: users.id).createUser(displayName, email, user.uid);

      return 'Pass';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The Password is too weak');
        return 'WeakPassword';
      } else if (e.code == 'email-already-in-use') {
        print('The Account already exists for that email');
        return 'ExistingAccount';
      } else if (e.code == 'invalid-email') {
        print('The email address is badly formatted.');
        return 'InvalidEmail';
      } else {
        print(e.toString());
        return 'GenericError';
      }
    }
  }
}
