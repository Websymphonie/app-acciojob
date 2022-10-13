import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData ligthTheme(BuildContext context) => ThemeData(
        buttonTheme: ButtonThemeData(buttonColor: primaryColor),
        brightness: Brightness.light,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.white,
        canvasColor: creamColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        buttonTheme: ButtonThemeData(buttonColor: primaryColor),
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.poppins().fontFamily,
        cardColor: Colors.black,
        canvasColor: darkCreamColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.black,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black54),
        ),
      );

  //Colors
  static Color whiteColor = Color(0xffffffff);
  static Color blackColor = Color(0xff000000);
  static Color creamColor = Color(0xfff5f5f5);
  static Color darkCreamColor = Color(0xff16182d);
  static Color primaryColor = Color(0xfff6a820);
  static Color darkBlueColor = Color(0xff16182d);
  static Color ligthPrimaryColor = Color(0xfff6a820);
  static Color successPrimary = Color.fromARGB(255, 2, 163, 88);
  static Color successSecondary = Color.fromARGB(255, 90, 238, 85);
  static Color dangerPrimary = Color.fromARGB(255, 163, 13, 2);
  static Color dangerSecondary = Color.fromARGB(255, 255, 7, 48);
  static double fontSizeInput = 18.0;
}
