import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:recipe_checked/controllers/authenticationController.dart';

import 'navBar.dart';

class SignupPage extends StatelessWidget {
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myUsernameController = TextEditingController();
  final myConfirmpasswordController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
            print('Back to welcome page');
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 80,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Sign up",
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Create an account, It's free ",
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Username',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 5),
                  TextField(
                      controller: myUsernameController,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      obscureText: false),
                  Text('Email Address',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 5),
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: myEmailController,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      obscureText: false),
                  Text('Password',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 5),
                  TextField(
                      controller: myPasswordController,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      obscureText: true),
                  Text('Confirm Password',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 5),
                  TextField(
                      controller: myConfirmpasswordController,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      obscureText: true),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 3, left: 3),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    print("Sign up pressed");
                    bool samePassword = await AuthenticationController()
                        .checkSamePassword(myPasswordController.text.trim(),
                            myConfirmpasswordController.text.trim());
                    if (samePassword == true) {
                      final signupCode = await AuthenticationController()
                          .registerWithEmailAndPassword(
                              myUsernameController.text.trim(),
                              myEmailController.text.trim(),
                              myPasswordController.text.trim());
                      if (signupCode == 'Pass') {
                        // globals.currUserId =
                        //     FirebaseAuth.instance.currentUser.uid;
                        Phoenix.rebirth(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Navbar()));
                      } else if (signupCode == 'WeakPassword') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text(
                                      "Password is too weak. Minimum 6 characters required."),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleMedium);
                            });
                      } else if (signupCode == 'ExistingAccount') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text(
                                      "Account with email already exists. Please log in."),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleMedium);
                            });
                      } else if (signupCode == 'InvalidEmail') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text(
                                      "The email address is badly formatted. Please try again with proper email address."),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleMedium);
                            });
                      } else if (signupCode == 'GenericError') {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text(
                                      "Failed to sign up. Please try again with proper input."),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleMedium);
                            });
                      }
                    } else if (samePassword == false) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text(
                                    "Password confirmation does not match."),
                                titleTextStyle:
                                    Theme.of(context).textTheme.titleMedium);
                          });
                    }
                  },
                  color: const Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  child: Text("Sign up",
                      style: Theme.of(context).textTheme.labelLarge),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                      child: Text("Log in",
                          style: Theme.of(context).textTheme.labelLarge),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/Login', (_) => false);
                        print('Signup -> Login Pressed');
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
