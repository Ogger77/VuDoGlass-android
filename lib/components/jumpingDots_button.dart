import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';
import 'jumping_dots.dart';

class JumpingDotsButton extends StatelessWidget {
  const JumpingDotsButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          // primary: kPrimaryColor,
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: JumpingDots(),
      ),
    );
  }
}
