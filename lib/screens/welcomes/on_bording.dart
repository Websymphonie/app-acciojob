import 'package:acciojob/screens/welcomes/slider_pages.dart';
import 'package:acciojob/services/controllers/static_service_controller.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBording extends StatefulWidget {
  OnBording({Key? key}) : super(key: key);

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  int _currentPage = 0;
  int duration = 800;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    Get.find<StaticServiceController>().getServices();
  }

  _onChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticServiceController>(builder: (staticservice) {
      return Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: staticservice.serviceList.length,
              controller: _pageController,
              onPageChanged: _onChange,
              itemBuilder: (context, int index) {
                var service = staticservice.serviceList[index];
                return SliderPages(
                    title: service.name,
                    description: service.description,
                    image: (service.filename == null)
                        ? AppConstants.IMAGE_URL_STATIC_SERVICE +
                            AppConstants.DEFAULT_ILLUSTRATION
                        : AppConstants.IMAGE_URL_STATIC_SERVICE +
                            service.filename);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(staticservice.serviceList.length,
                      (int index) {
                    return AnimatedContainer(
                      duration: Duration(microseconds: duration),
                      height: Dimensions.height10,
                      width: (index == _currentPage)
                          ? Dimensions.height30
                          : Dimensions.height10,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.height5,
                          vertical: Dimensions.height30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.height5),
                        color: _currentPage == index
                            ? MyThemes.primaryColor
                            : MyThemes.primaryColor.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_currentPage != staticservice.serviceList.length - 1)
                        ? GestureDetector(
                            onTap: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool(
                                  AppConstants.APP_SHOW_SECURITY, true);
                              Get.offAllNamed(RouteHelper.security);
                            },
                            child: Text(
                              "Ignorer",
                              style: TextStyle(
                                color: MyThemes.blackColor.withOpacity(0.5),
                                fontSize: Dimensions.font18,
                              ),
                            ),
                          )
                        : Container(),
                    (_currentPage != staticservice.serviceList.length - 1)
                        ? SizedBox(
                            width: Dimensions.height70,
                          )
                        : Container(),
                    InkWell(
                      onTap: () async {
                        if ((_currentPage ==
                            staticservice.serviceList.length - 1)) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool(AppConstants.APP_SHOW_SECURITY, true);
                          Get.offAllNamed(RouteHelper.security);
                        } else {
                          _pageController.nextPage(
                            duration: Duration(microseconds: duration),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(microseconds: duration),
                        height: Dimensions.height50,
                        alignment: Alignment.center,
                        width: (_currentPage ==
                                staticservice.serviceList.length - 1)
                            ? Dimensions.height200
                            : Dimensions.height50,
                        decoration: BoxDecoration(
                          color: MyThemes.primaryColor,
                          borderRadius: BorderRadius.circular(
                            Dimensions.height30,
                          ),
                        ),
                        child: (_currentPage ==
                                staticservice.serviceList.length - 1)
                            ? Text(
                                'COMMENCER',
                                style: TextStyle(
                                  color: MyThemes.whiteColor,
                                  fontSize: Dimensions.font18,
                                ),
                              )
                            : Icon(
                                Icons.navigate_next,
                                color: MyThemes.whiteColor,
                                size: Dimensions.height50,
                              ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height50,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
