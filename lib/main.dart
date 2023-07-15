import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:recipe_checked/firebase_options.dart';
import 'package:recipe_checked/pages/favourites.dart';
import 'package:recipe_checked/pages/store.dart';
import 'package:recipe_checked/theme/themeManager.dart';
import 'package:provider/provider.dart';
import 'package:recipe_checked/pages/loginpage.dart';
import 'package:recipe_checked/pages/signuppage.dart';
import 'package:recipe_checked/wrapper.dart';

import 'data/appUser.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(), child: Phoenix(child: const MyApp())));
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({required this.resumeCallBack});

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    User? currUser = FirebaseAuth.instance.currentUser;

    String? uid = (currUser == null) ? null : currUser.uid;

    return MultiProvider(
        providers: [
          StreamProvider<AppUser>.value(
            initialData: AppUser.createAppuserFromFirestore(
                uid as DocumentSnapshot<Object?>),
            value: AppUser.getUserFromID(uid),
          )
        ],
        child: Consumer<ThemeNotifier>(
          builder: (context, theme, _) => MaterialApp(
            theme: theme.getTheme(),
            initialRoute: '/',
            routes: {
              '/': (context) => const Wrapper(),
              '/Login': (context) => const LoginPage(),
              '/Signup': (context) => SignupPage(),
              '/Favourites': (context) => const Favourites(),
              '/Store': (context) => const Store(),
            },
            // home: Scaffold(
            //   bottomNavigationBar: Navbar(),
            //   body: Navigator(
            //     onGenerateRoute: (settings) {
            //       Widget page = Homepage();
            //       if (settings.name == 'Store') page = Store();
            //       else if (settings.name == 'Favourites') page = Favourites();
            //       else if (settings.name == 'Homepage') page = Homepage();
            //       return MaterialPageRoute(builder: (_) => page);
            //     },
            //   ),
            // )
            // MainPage(),
          ),
        ));
  }
}
