import 'package:acciojob/screens/orders/orders_screen.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/order_controller.dart';
import 'package:acciojob/services/controllers/service_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/commandes/commande.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/app_icon.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class DetailsOrder extends StatefulWidget {
  final UserModel? user;
  final Commandes commande;
  DetailsOrder({
    Key? key,
    required this.user,
    required this.commande,
  }) : super(key: key);

  @override
  State<DetailsOrder> createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  @override
  void initState() {
    super.initState();
    Get.find<ServiceController>().getServiceList();
    Get.find<UserController>().getUserInfos();
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd-MM-yyyy à H:i:s')
        .format(DateTime.parse(widget.commande.dateHeure!));

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.orderImageSize200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.commande.categories!.filename != null
                            ? AppConstants.IMAGE_URL_SERVICE +
                                widget.commande.categories!.filename!
                            : AppConstants.IMAGE_URL_DEFAULT,
                      ))),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<UserController>(builder: (userController) {
                  return IconButton(
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: CustomSearchDelegate(
                              user: userController.userModel));
                    },
                    icon: AppIcon(icon: Icons.search),
                  );
                }),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.orderImageSize200 - 50,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Commande #" + widget.commande.reference!,
                      size: Dimensions.font16,
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(Dimensions.height5),
                          decoration: BoxDecoration(
                            color: HexColor(widget.commande.status!.color!),
                            borderRadius:
                                BorderRadius.circular(Dimensions.height10),
                          ),
                          child: SmallText(
                            text: widget.commande.status!.name!,
                            size: Dimensions.font10,
                            color: Colors.white,
                          ),
                        ),
                        SmallText(
                          text: date.toString(),
                          color: Colors.black54,
                          size: Dimensions.font13,
                        ),
                      ],
                    ),
                    SizedBox(height: Dimensions.height16),
                    Container(
                      child: buldBodyContent(context, widget.commande),
                    ),
                    SizedBox(height: Dimensions.height20),
                    GetBuilder<UserController>(builder: (userController) {
                      return widget.commande.status!.id == 1
                          ? AppButton(
                              label: "Annuler la commande",
                              onTap: () {
                                Get.defaultDialog(
                                  title: "Confirmation",
                                  titleStyle: TextStyle(
                                    fontSize: Dimensions.font18,
                                  ),
                                  content: Text(
                                      "Voulez vous annuler cette commande?"),
                                  textConfirm: "Oui",
                                  textCancel: "Non",
                                  cancelTextColor: MyThemes.blackColor,
                                  confirmTextColor: MyThemes.whiteColor,
                                  buttonColor: MyThemes.primaryColor,
                                  onConfirm: () {
                                    if (Get.find<LoginController>()
                                        .userLoggedIn()) {
                                      var orderController =
                                          Get.find<OrderController>();
                                      orderController.cancel(widget.commande,
                                          userController.userModel);
                                      Get.offAll(
                                        OrdersScreen(
                                            user: userController.userModel),
                                      );
                                    }
                                  },
                                );
                              },
                              backgroundColor: MyThemes.dangerPrimary,
                              textColor: MyThemes.whiteColor,
                            )
                          : Container();
                    }),
                    SizedBox(height: Dimensions.height20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buldBodyContent(context, Commandes commande) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTotal(context, commande),
        SizedBox(height: Dimensions.height16),
        (commande.adresse != null || commande.communes != null)
            ? buildCardInfos(context, commande)
            : Text(''),
        SizedBox(height: Dimensions.height5),
        buildOrderItems(commande),
        SizedBox(
          height: Dimensions.height20,
        ),
        Container(
          padding: EdgeInsets.only(
              left: Dimensions.height15, right: Dimensions.height15),
          child: BigText(
            text: 'Frais annexes',
            size: Dimensions.font18,
          ),
        ),
        Divider(
          height: Dimensions.height5,
          color: Colors.grey,
        ),
        ListView(
          padding: EdgeInsets.only(top: Dimensions.height10, bottom: 0),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            commande.priceBase != 0
                ? Card(
                    color: MyThemes.creamColor,
                    child: ListTile(
                      title: Text("Prix de base"),
                      subtitle: Text(commande.priceBase.toString() + " FCFA"),
                    ),
                  )
                : SizedBox(),
            commande.priceTransportService != 0
                ? Card(
                    color: MyThemes.creamColor,
                    child: ListTile(
                      title: Text("Frais de transport"),
                      subtitle: Text(
                          commande.priceTransportService.toString() + " FCFA"),
                    ),
                  )
                : SizedBox(),
          ],
        )
      ],
    );
  }

  Widget buildTotal(context, Commandes commande) {
    int total = widget.commande.total!;
    if (widget.commande.priceBase != 0) {
      setState(() {
        total += widget.commande.priceBase!;
      });
    }
    if (widget.commande.priceTransportService != 0) {
      setState(() {
        total += widget.commande.priceTransportService!;
      });
    }
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(Dimensions.height5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius50),
        color: HexColor(widget.commande.status!.color!),
      ),
      child: Text(
        "Total: " + total.toString() + " FCFA",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: MyThemes.blackColor,
          fontSize: Dimensions.font20,
        ),
      ),
    );
  }

  Widget buildCardInfos(context, Commandes commandes) {
    final width = MediaQuery.of(context).size.width * 0.9;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          color: MyThemes.whiteColor,
          padding: EdgeInsets.all(Dimensions.height15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: 'Information de la commande',
                size: Dimensions.font18,
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              Divider(
                height: Dimensions.height5,
                color: Colors.grey,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              commandes.communes != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'Commune:',
                          size: Dimensions.font15,
                          color: Colors.black54,
                        ),
                        SmallText(
                          text: commandes.communes!.name!,
                          size: Dimensions.font15,
                          color: Colors.black54,
                        )
                      ],
                    )
                  : Text(''),
              SizedBox(
                height: Dimensions.height10,
              ),
              commandes.adresse != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: 'Adresse:',
                          size: Dimensions.font15,
                          color: Colors.black54,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: SmallText(
                            text: commandes.adresse!,
                            size: Dimensions.font13,
                            color: Colors.black54,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  : Text('')
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOrderItems(Commandes commandes) {
    return Column(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: Dimensions.height10, bottom: 0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: commandes.linecommandes!.length,
            itemBuilder: (context, index) {
              final linecommande = commandes.linecommandes![index];
              int totalLine = 0;
              if (linecommande.quantity != 0) {
                totalLine = linecommande.price! * linecommande.quantity!;
              } else {
                totalLine = linecommande.price!;
              }

              return Card(
                color: MyThemes.creamColor,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(linecommande.groupes!.name!),
                      subtitle: Wrap(
                        children: [
                          Text(linecommande.items!.name!),
                          SizedBox(
                            width: Dimensions.width20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              linecommande.groupes!.champ! == "radio"
                                  ? Text(
                                      linecommande.price!.toString() + " x 1 ")
                                  : Text(
                                      linecommande.price!.toString() +
                                          " x " +
                                          linecommande.quantity!.toString(),
                                    ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Text(totalLine.toString() + " FCFA")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
