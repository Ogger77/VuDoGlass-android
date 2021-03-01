import 'package:flutter/material.dart';
import '../../../screens/home/home_screen.dart';

import '../../../components/default_button.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          'assets/images/success.png',
          height: SizeConfig.screenHeight * 0.5, //40% of the screen
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionScreenWidth(25),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: 'Back to home',
            press: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
