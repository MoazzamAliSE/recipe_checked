import 'package:flutter/material.dart';
import 'package:recipe_checked/controllers/loginController.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_checked/pages/navBar.dart';
import 'package:recipe_checked/widget/signinwidget.dart';
import 'package:recipe_checked/components/loading.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => LoginController(),
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              final provider = Provider.of<LoginController>(context);

              if (provider.isSigningIn) {
                return const Loading();
              } else if (snapshot.hasData) {
                return Navbar();
              } else {
                // print ('Snapshot has no data');
                return SignInWidget();
              }
            },
          ),
        ),
      );
}

// we will be creating a widget for text field
/*Widget inputFile({label, obscureText = false}) {
  final myController = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        controller: myController,
        obscureText: obscureText,
        decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]),),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[400]))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}*/
