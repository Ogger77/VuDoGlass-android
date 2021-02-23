import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Auth.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 9),
        ProfileMenu(
          icon: 'assets/icons/User Icon.svg',
          text: 'My Account',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Bell.svg',
          text: 'Notifications',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Question mark.svg',
          text: 'Settings',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Question mark.svg',
          text: 'Help Center',
          press: () {},
        ),
        ProfileMenu(
          icon: 'assets/icons/Log out.svg',
          text: 'Log out',
          press: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}
