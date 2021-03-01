import 'package:flutter/material.dart';

import '../../../components/social_card.dart';
import '../../../screens/sign_up/components/sign_up_form.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatelessWidget {
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
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(
                  "Register Account",
                  style: headingStyle,
                ),
                Text(
                  'Complete your deatils or continue \nwith scocial media',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height: SizeConfig.screenHeight *
                        0.02), //8% of the screen total height
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.07), //8% of
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {},
                    ),
                    SocialCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: () {},
                    ),
                    SocialCard(
                      icon: 'assets/icons/twitter.svg',
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionScreenHeight(20)),
                Text(
                  'By continuing, you are confirming that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
