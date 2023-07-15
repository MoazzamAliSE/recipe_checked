import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:recipe_checked/pages/loginpage.dart';
import 'package:recipe_checked/pages/signuppage.dart';
import 'package:recipe_checked/controllers/loginController.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) LoginController().signOut();
    Size size = MediaQuery.of(context).size;
    // This size provides us total height and width of our screen
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Welcome to Recipe Ventures",
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center),
                  SizedBox(height: 10),
                ],
              ),
              Container(
                height: size.height / 3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage("assets/images/Recipe Ventures.png"))),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        print("Login Button Pressed");
                        Navigator.pushNamed(context, '/Login');
                        /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));*/
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2.5,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text("Login",
                          style: Theme.of(context).textTheme.button)),
                  SizedBox(height: 20),
                  MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        // var now = DateTime.now();
                        // Map<String, dynamic> x = new Map();
                        // x["name"] = "egg";
                        // x["expiryDate"] = now;
                        // StoreController().addIngredients(
                        //     [x], "wHUYMSwrhBWajUyw8QqLbvfEuIr1");

                        print("Signup Button Pressed");
                        Navigator.pushNamed(context, '/Signup');
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()));*/
                      },
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: Text("Sign Up",
                          style: Theme.of(context).textTheme.button)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
