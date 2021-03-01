import 'package:flutter/material.dart';

import '../../../models/Product.dart';
import '../../../screens/details/details_screen.dart';

import '../../../size_config.dart';
import 'product_card.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          text: 'Popular Product',
          press: () {},
        ),
        SizedBox(height: getProportionScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) => ProductCard(
                  product: demoProducts[index],
                  press: () => Navigator.pushNamed(
                    context,
                    DetailsScreen.routeName,
                    arguments:
                        ProductDetailArguments(product: demoProducts[index]),
                  ),
                ),
              ),
              SizedBox(width: getProportionScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}
