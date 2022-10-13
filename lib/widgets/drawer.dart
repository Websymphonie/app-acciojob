import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/pages/abouts.dart';
import 'package:acciojob/pages/confidentialite.dart';
import 'package:acciojob/pages/contacts.dart';
import 'package:acciojob/screens/orders/orders_screen.dart';
import 'package:acciojob/pages/security/profil.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    bool _userLoggedIn = Get.find<LoginController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfos();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const String imageAvatar = "assets/images/avatar.png";
    return GetBuilder<UserController>(builder: (userController) {
      return Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(userController.userModel.nom! +
                      ' ' +
                      userController.userModel.prenoms!),
                  accountEmail: Text(userController.userModel.email!),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(imageAvatar),
                  ),
                  decoration: BoxDecoration(
                    color: MyThemes.primaryColor,
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Get.toNamed(RouteHelper.getHomePage()),
                  leading: Icon(
                    CupertinoIcons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Accueil",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ProfilScreen(user: userController.userModel),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.1);
                        var curve = Curves.ease;
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  ),
                  leading: Icon(
                    CupertinoIcons.pencil,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Modifier mon profil",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          OrdersScreen(user: userController.userModel),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.1);
                        var curve = Curves.ease;
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  ),
                  leading: Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Historique des commandes",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          About(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.1);
                        var curve = Curves.ease;
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Qui sommes nous",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Confidentialite(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.1);
                        var curve = Curves.ease;
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  ),
                  leading: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Confidentialité",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Contact(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.1);
                        var curve = Curves.ease;
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  ),
                  leading: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Contactez-nous",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    userController.clearShareData();
                    showCustomSnackBar(
                      "Vous êtes déconnecté",
                      isError: false,
                      title: "Info",
                      color: MyThemes.whiteColor,
                      background: MyThemes.successPrimary,
                    );
                    Get.offAllNamed(RouteHelper.getSecurityPage());
                  },
                  leading: Icon(
                    CupertinoIcons.clear_circled,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Se déconnecter",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
