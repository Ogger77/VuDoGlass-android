import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Cart.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckOutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return AppBar(
      title: Column(
        children: [
          Text(
            'Your Cart',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '${cart.itemCount} items',
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
