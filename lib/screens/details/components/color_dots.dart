import 'package:flutter/material.dart';

import '../../../components/rounded_icon_btn.dart';
import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    //use fixed demo for now
    int selectedColor = 3;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionScreenWidth(20)),
      child: Row(
        children: [
          ...List.generate(
            product.colors.length,
            (index) => ColorDot(
              color: product.colors[index],
              isSelected: selectedColor == index,
            ),
          ),
          Spacer(),
          RoundedIconBtn(
            iconData: Icons.remove,
            press: () {},
          ),
          SizedBox(width: getProportionScreenWidth(15)),
          RoundedIconBtn(
            iconData: Icons.add,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      //outer cirlce
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(8),
      height: getProportionScreenWidth(40),
      width: getProportionScreenWidth(40),
      decoration: BoxDecoration(
        // color: product.colors[0],
        shape: BoxShape.circle,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
      ),
      //inner circle
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
