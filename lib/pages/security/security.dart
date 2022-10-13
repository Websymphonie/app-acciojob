import 'package:acciojob/commons/delayed_animation.dart';
import 'package:acciojob/utils/conectivity_provider.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/no_connexion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      return Scaffold(
        backgroundColor: MyThemes.creamColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/login_cover2.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: model.isOnline
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      DelayedAnimation(
                        delay: 1000,
                        child: SvgPicture.asset(
                          "assets/images/logo-login.svg",
                          width: double.maxFinite,
                          height: Dimensions.height170,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.30,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: Dimensions.width40,
                          right: Dimensions.width40,
                          top: Dimensions.height20,
                        ),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DelayedAnimation(
                              delay: 1500,
                              child: AppButton(
                                label: "Se connecter",
                                backgroundColor: MyThemes.whiteColor,
                                textColor: MyThemes.darkBlueColor,
                                onTap: () {
                                  Get.toNamed(RouteHelper.getLoginPage());
                                },
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height15,
                            ),
                            DelayedAnimation(
                              delay: 2000,
                              child: AppButton(
                                label: "S'inscrire",
                                onTap: () {
                                  Get.toNamed(RouteHelper.getRegisterPage());
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : NoConnexion(),
          ),
        ),
      );
    });
  }
}
