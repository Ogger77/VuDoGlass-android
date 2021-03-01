import 'package:flutter/material.dart';

import '../../../size_config.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_products.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionScreenWidth(20)),
            HomeHeader(),
            SizedBox(height: getProportionScreenWidth(30)),
            DiscountBanner(),
            SizedBox(height: getProportionScreenWidth(30)),
            Categories(),
            SizedBox(height: getProportionScreenWidth(30)),
            SpecialOffers(),
            SizedBox(height: getProportionScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
