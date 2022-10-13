import 'package:acciojob/pages/confidentialite.dart';
import 'package:acciojob/pages/home_page.dart';
import 'package:acciojob/pages/security/login.dart';
import 'package:acciojob/pages/security/register.dart';
import 'package:acciojob/pages/security/profil.dart';
import 'package:acciojob/pages/security/security.dart';
import 'package:acciojob/screens/splashs/splash_screen.dart';
import 'package:acciojob/screens/welcomes/on_bording.dart';
import 'package:acciojob/widgets/no_connexion.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String security = "/security";
  static const String login = "/login";
  static const String register = "/register";
  static const String profile = "/profile";
  static const String confidentialite = "/confidentialite";
  static const String noconnexion = "/no-connexion";
  static const String splash = "/splash";
  static const String welcome = "/welcome";

  static String getHomePage() => initial;
  static String getSecurityPage() => security;
  static String getLoginPage() => login;
  static String getRegisterPage() => register;
  static String getProfilePage() => profile;
  static String getConfidentialitePage() => confidentialite;
  static String getNoConnexionPage() => noconnexion;
  static String getSplashScreen() => splash;
  static String getWelcomeScreen() => welcome;

  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () {
        return Homepage();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: security,
      page: () {
        return SecurityScreen();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () {
        return Login();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: register,
      page: () {
        return Register();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: profile,
      page: () {
        return ProfilScreen();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: confidentialite,
      page: () {
        return Confidentialite();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: noconnexion,
      page: () {
        return NoConnexion();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: splash,
      page: () {
        return SplashScreen();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: welcome,
      page: () {
        return OnBording();
      },
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
