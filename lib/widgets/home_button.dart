import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: MyThemes.primaryColor,
      foregroundColor: MyThemes.whiteColor,
      onPressed: () => Get.offAllNamed(RouteHelper.initial),
      mini: true,
      child: Icon(Icons.home),
    );
  }
}
