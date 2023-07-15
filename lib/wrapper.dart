import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_checked/data/appUser.dart';
import 'package:recipe_checked/pages/navBar.dart';
import 'package:recipe_checked/pages/welcomepage.dart';

import 'components/loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final appUser = Provider.of<AppUser>(context);
    // String uid = globals.currUserId;

    if (user == null) {
      return const WelcomePage();
    } else if (appUser.uid != user.uid) {
      print("loading user");
      return const Loading();
    } else {
      // return Homepage();
      // print("printing from wrapper");
      // print(appUser);
      // print(user);
      return Navbar();
    }

    return Container();
  }
}
