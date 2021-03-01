import 'package:flutter/material.dart';
import 'package:shop_app/components/jumping_dots.dart';
import 'package:shop_app/size_config.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: JumpingDots(),
    );
  }
}
