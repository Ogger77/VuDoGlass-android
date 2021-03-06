import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionScreenWidth(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.01),
              Text(
                'Complete Profile',
                style: headingStyle,
              ),
              Text(
                'Complete your profile details',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              CompleteProfileForm(),
              SizedBox(height: getProportionScreenHeight(30)),
              Text(
                'By continuing, you are confirming that you agree \nwith our Term and Condition',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getProportionScreenHeight(22)),
            ],
          ),
        ),
      ),
    );
  }
}
