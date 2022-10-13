import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final bool? isLoading;
  final VoidCallback onTap;

  const AppButton({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.isLoading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: backgroundColor ?? MyThemes.darkBlueColor,
          borderRadius: BorderRadius.circular(Dimensions.radius25),
        ),
        duration: Duration(seconds: 1),
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? Dimensions.height40,
        alignment: Alignment.center,
        child: isLoading!
            ? CircularProgressIndicator()
            : Text(
                label,
                style: TextStyle(
                  color: textColor ?? MyThemes.whiteColor,
                  fontSize: Dimensions.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
