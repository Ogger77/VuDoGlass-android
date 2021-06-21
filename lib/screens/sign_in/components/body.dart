import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../../home/home_screen.dart';

import '../../../size_config.dart';
import '../../../components/no_account_text.dart';
import '../../../components/social_card.dart';

import 'custom_web_view.dart';
import 'signin_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //google oauth
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserCredential user;

  //facebook oauth
  // ignore: non_constant_identifier_names
  String your_client_id = "856576748231209";
  // ignore: non_constant_identifier_names
  String your_redirect_url =
      "https://www.facebook.com/connect/login_success.html";

  //google sing-in
  void signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    //Create Google Auth credentials to pass to Firebase
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //Authenticate against Firebase with Google credentials
    await firebaseAuth
        .signInWithCredential(googleAuthCredential)
        .then((userCredential) => {
              setState(() => {user = userCredential})
            });
    showSnackBar(context);
    new Timer(new Duration(seconds: 3),
        () => Navigator.pushNamed(context, HomeScreen.routeName));
  }

  //facebook signin
  void signInWithFacebook() async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CustomWebView(
                selectedUrl:
                    'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
              ),
          maintainState: true),
    );

    if (result != null) {
      try {
        final facebookAuthCred = FacebookAuthProvider.credential(result);
        final authResult =
            await firebaseAuth.signInWithCredential(facebookAuthCred);
        final User user = authResult.user;
        print(user);
        Navigator.pushNamed(context, HomeScreen.routeName);
      } catch (e) {
        print(e);
      }
    }
  }

  //twitter sign in
  // void signInWithTwitter() async {
  //   var result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => TwitterLoginScreen(
  //         consumerKey: 'QGgAKbMUIAgmLOQbmOK81Au77',
  //         consumerSecret: 'kFodEiMe9mBidslRxlTZDkonfLZdN98j7PZLlJtjCdGgjLRLqO',
  //         oauthCallbackHandler:
  //             'https://shop-app-ad2bb.firebaseapp.com/__/auth/handler',
  //       ),
  //     ),
  //   );
  //   print(result);
  //   // Create a credential from the access token
  //   final AuthCredential twitterAuthCredential = TwitterAuthProvider.credential(
  //       accessToken: result.token, secret: result.secret);

  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
  // }

  void showSnackBar(BuildContext context) async {
    final snackBar = SnackBar(
      //add user name
      content: Text('Welcome back, Dinh'),
      backgroundColor: kPrimaryColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Continue',
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: getProportionScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sign in with your email and password \nor continue with social media',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {
                        signInWithGoogle();
                      },
                    ),
                    SocialCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: () {
                        signInWithFacebook();
                      },
                    ),
                    SocialCard(
                      icon: 'assets/icons/twitter.svg',
                      press: () {
                        //wait for approval from twitter
                        // signInWithTwitter();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionScreenHeight(20),
                ),
                NoAccountText(),
                SizedBox(
                  height: getProportionScreenHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
