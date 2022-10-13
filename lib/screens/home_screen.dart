import 'package:acciojob/commons/custom_video_loader.dart';
import 'package:acciojob/pages/home_page.dart';
import 'package:acciojob/pages/services/service_children.dart';
import 'package:acciojob/services/controllers/service_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/services/service.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/drawer.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return GetBuilder<ServiceController>(builder: (service) {
        return service.isLoaded
            ? Scaffold(
                drawer: MyDrawer(),
                appBar: AppBar(
                  backgroundColor: MyThemes.primaryColor,
                  title: TitleWidget(label: "Bienvenue à Accio Job"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: MyThemes.blackColor,
                        size: Dimensions.iconSize24,
                      ),
                    ),
                  ],
                ),
                backgroundColor: MyThemes.creamColor,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Dimensions.height15),
                      child: HeaderSection(),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Dimensions.height15),
                        child: GridView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: service.serviceList.length,
                          itemBuilder: (context, index) {
                            return ServiceItem(service.serviceList[index],
                                userController.userModel);
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: Dimensions.width12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : CustomVideoLoader();
      });
    });
  }

  Widget ServiceItem(service, user) {
    double c_width = MediaQuery.of(context).size.width * 0.8;
    return Container(
      width: c_width,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.height7),
      height: itemSize,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ServiceChildrenPage(
                    service: service,
                    user: widget.user,
                  ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var tween = Tween(begin: begin, end: end);
                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              }),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: Key(service.id.toString()),
                child: ServiceImage(service: service),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: itemSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius15),
                    bottomRight: Radius.circular(Dimensions.radius15),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height7),
                child: Text(
                  service.name!,
                  style: TextStyle(
                    color: MyThemes.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.topCenter,
        heightFactor: 1,
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: Dimensions.width150,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Facilitez-vous la vie en commandant un prestataire à domicile avec AccioJob',
              style: TextStyle(
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class ServiceImage extends StatelessWidget {
  final Service service;

  const ServiceImage({Key? key, required this.service}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.radius15),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.png',
        image: service.filename != null
            ? AppConstants.IMAGE_URL_SERVICE + service.filename!
            : AppConstants.IMAGE_URL_DEFAULT,
        fit: BoxFit.cover,
      ),
    );
  }
}
