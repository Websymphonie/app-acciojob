import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,
    {bool isError = true,
    String title = 'Erreur',
    Color? color = Colors.white,
    Color? background = Colors.black,
    String? position = 'TOP'}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(
      text: title,
      color: color ?? MyThemes.whiteColor,
    ),
    messageText: Text(
      message,
      style: TextStyle(
        color: color ?? MyThemes.whiteColor,
      ),
    ),
    colorText: color ?? MyThemes.whiteColor,
    snackPosition: position == 'TOP' ? SnackPosition.TOP : SnackPosition.BOTTOM,
    backgroundColor: isError == true
        ? MyThemes.dangerPrimary
        : (background ?? MyThemes.dangerPrimary),
  );
}
