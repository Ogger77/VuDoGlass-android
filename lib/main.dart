import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './routs.dart';
import './screens/splash/splash_screen.dart';
import './theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VuDoGlass',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      // home:
      routes: routes,
    );
  }
}
