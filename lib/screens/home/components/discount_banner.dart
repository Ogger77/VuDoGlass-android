import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getProportionScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionScreenWidth(20),
        vertical: getProportionScreenWidth(15),
      ),
      width: double.infinity,
      // height: 90,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          text: 'A Summer Surprise\n',
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: 'New inventory',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
