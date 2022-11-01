import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height100 / 2),
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Theme.of(context).brightness == Brightness.light
              ? MyThemes.primaryColor
              : MyThemes.primaryColor,
        ),
      ),
    );
  }
}
