import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          'VuDoGlass',
          style: TextStyle(
            fontSize: getProportionScreenWidth(36),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionScreenWidth(14),
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionScreenHeight(265),
          width: getProportionScreenHeight(235),
        ),
      ],
    );
  }
}
