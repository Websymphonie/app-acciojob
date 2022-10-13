import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';

class AppPickLocation extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isLoading;
  final VoidCallback onTap;

  const AppPickLocation({
    Key? key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
    this.isLoading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? Dimensions.height50,
      color: backgroundColor ?? Colors.grey.withOpacity(0.5),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            SizedBox(
              width: Dimensions.width5,
            ),
            Text(
              label,
              style: TextStyle(
                color: textColor ?? MyThemes.darkBlueColor,
                fontSize: fontSize ?? Dimensions.font18,
                fontWeight: fontWeight ?? FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
