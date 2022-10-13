import 'package:acciojob/pages/home_page.dart';
import 'package:acciojob/pages/services/infos_service.dart';
import 'package:acciojob/pages/services/service_details.dart';
import 'package:acciojob/pages/services/service_other_details.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/children.dart';
import 'package:acciojob/services/models/services/service.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceChildrenPage extends StatefulWidget {
  final UserModel? user;
  final Service service;

  const ServiceChildrenPage(
      {Key? key, required this.service, required this.user})
      : super(key: key);

  @override
  State<ServiceChildrenPage> createState() => _ServiceChildrenPageState();
}

class _ServiceChildrenPageState extends State<ServiceChildrenPage> {
  List<Children> items = [];
  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getUserInfos();
    setState(() {
      items = widget.service.children!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(
            label: widget.service.name!, textOverflow: TextOverflow.ellipsis),
        actions: [
          GetBuilder<UserController>(builder: (userController) {
            return IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(user: widget.user));
              },
              icon: Icon(
                Icons.search,
                color: MyThemes.blackColor,
                size: Dimensions.iconSize24,
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<UserController>(builder: (userController) {
        return BottomAppBar(
          color: MyThemes.primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            height: Dimensions.height45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: Dimensions.iconSize24,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(
                        user: userController.userModel,
                      ),
                    ),
                  ),
                  iconSize: Dimensions.iconSize30,
                ),
                IconButton(
                  icon: Icon(
                    Icons.info_rounded,
                    color: Colors.white,
                    size: Dimensions.iconSize24,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfosServiceScreen(
                          service: widget.service,
                          user: userController.userModel),
                    ),
                  ),
                  iconSize: Dimensions.iconSize30,
                ),
              ],
            ),
          ),
        );
      }),
      backgroundColor: MyThemes.creamColor,
      body: GetBuilder<UserController>(builder: (userController) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Hero(
                tag: Key(widget.service.id.toString()),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: widget.service.filename != null
                      ? AppConstants.IMAGE_URL_SERVICE +
                          widget.service.filename!
                      : AppConstants.IMAGE_URL_DEFAULT,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.orderImageSize200 - 20,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(
                    left: Dimensions.width5,
                    right: Dimensions.width5,
                    top: Dimensions.height20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius30),
                      topRight: Radius.circular(Dimensions.radius30),
                    ),
                    color: MyThemes.creamColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Dimensions.height16),
                        color: MyThemes.creamColor,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: Dimensions.height10 + 2,
                                right: Dimensions.height10 + 2,
                                bottom: Dimensions.height10 + 2,
                              ),
                              child: Text(
                                widget.service.name!,
                                style: TextStyle(
                                  color: MyThemes.darkBlueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font18,
                                ),
                              ),
                            ),
                            childrenItem(userController.userModel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  childrenItem(user) {
    return items.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final Children servicechild = items[index];
              return InkWell(
                onTap: () {
                  if (Get.find<LoginController>().userLoggedIn()) {
                    servicechild.is_filter == false
                        ? Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ServiceDetailsPage(
                                          service: servicechild,
                                          user: user,
                                        ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end);
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                }),
                          )
                        : Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ServiceOtherDetailsPage(
                                          service: servicechild,
                                          user: user,
                                        ),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var begin = Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var tween = Tween(begin: begin, end: end);
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                }),
                          );
                  } else {
                    Get.offAllNamed(RouteHelper.getSecurityPage());
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Card(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: ListTile(
                        title: Text(
                          servicechild.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        leading: Hero(
                          tag: Key(servicechild.id.toString()),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                servicechild.filename != null
                                    ? AppConstants.IMAGE_URL_SERVICE +
                                        servicechild.filename!
                                    : AppConstants.IMAGE_URL_DEFAULT),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_circle_right)),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "Aucune donnée trouvée",
              style: TextStyle(color: MyThemes.blackColor),
            ),
          );
  }
}
