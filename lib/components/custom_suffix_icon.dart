import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';

import '../size_config.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);
  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionScreenWidth(20),
        getProportionScreenWidth(20),
        getProportionScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: getProportionScreenWidth(18),
        color: kPrimaryColor,
      ),
    );
  }
}
