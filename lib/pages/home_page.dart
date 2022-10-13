import 'package:acciojob/pages/abouts.dart';
import 'package:acciojob/pages/confidentialite.dart';
import 'package:acciojob/pages/contacts.dart';
import 'package:acciojob/screens/home_screen.dart';
import 'package:acciojob/pages/security/security.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/service_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/conectivity_provider.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/no_connexion.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

double itemSize = Dimensions.width150;

class Homepage extends StatefulWidget {
  final UserModel? user;
  Homepage({Key? key, this.user}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Get.find<ServiceController>().getServiceList();
    Get.find<UserController>().getUserInfos();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        if (Get.find<LoginController>().userLoggedIn()) {
          bool _userLoggedIn = Get.find<LoginController>().userLoggedIn();
          final screens = [
            HomeScreen(user: widget.user),
            About(),
            Confidentialite(),
            Contact(),
          ];

          final items = <Widget>[
            Icon(
              Icons.home,
              color: MyThemes.whiteColor,
              size: Dimensions.iconSize24,
            ),
            Icon(
              Icons.info,
              color: MyThemes.whiteColor,
              size: Dimensions.iconSize24,
            ),
            Icon(
              Icons.lock,
              color: MyThemes.whiteColor,
              size: Dimensions.iconSize24,
            ),
            Icon(
              Icons.phone,
              color: MyThemes.whiteColor,
              size: Dimensions.iconSize24,
            ),
          ];
          if (_userLoggedIn) {
            Get.find<UserController>().getUserInfos();
          }
          return SafeArea(
            top: false,
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar:
                  GetBuilder<UserController>(builder: (userController) {
                return CurvedNavigationBar(
                  key: _bottomNavigationKey,
                  color: MyThemes.primaryColor,
                  backgroundColor: MyThemes.whiteColor,
                  animationCurve: Curves.easeInOut,
                  animationDuration: Duration(microseconds: 1000),
                  height: Dimensions.height50,
                  index: _index,
                  items: items,
                  onTap: (ind) {
                    setState(() {
                      _index = ind;
                    });
                  },
                );
              }),
              body: screens[_index],
            ),
          );
        } else {
          return SecurityScreen();
        }
      } else {
        return NoConnexion();
      }
    });
  }
}
