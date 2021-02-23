import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/jumping_dots.dart';
import 'package:shop_app/screens/otp/test_otp.dart';

import './routs.dart';
import './screens/splash/splash_screen.dart';
import './theme.dart';
import 'models/Auth.dart';
import 'models/products.dart';
import 'screens/home/home_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: null,
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VuDoGlass',
          theme: theme(),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => authResultSnapshot
                              .connectionState ==
                          ConnectionState.waiting
                      ? SplashScreen() //add loading screen with jumping dots
                      : SignInScreen(),
                ),
          // initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      ),
    );
  }
}
