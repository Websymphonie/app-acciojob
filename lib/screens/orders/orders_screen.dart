import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/screens/orders/details_order.dart';
import 'package:acciojob/services/controllers/commande_controller.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/header_title.dart';
import 'package:acciojob/widgets/home_button.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class OrdersScreen extends StatefulWidget {
  final UserModel? user;
  const OrdersScreen({Key? key, this.user}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    if (Get.find<CommandeController>().commandeList.isEmpty) {
      Get.find<CommandeController>().getCommandes();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyThemes.primaryColor,
          title: TitleWidget(label: "Historique de commandes"),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(user: widget.user),
                );
              },
              icon: Icon(
                Icons.search,
                color: MyThemes.blackColor,
                size: Dimensions.iconSize24,
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: HomeButton(),
        body: GetBuilder<CommandeController>(builder: (commandeController) {
          var commandes = commandeController.commandeList;

          return !commandeController.isLoaded
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: HeaderTitle(
                        title: 'Commandes',
                        subtitle: 'Liste des commandes',
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height5,
                    ),
                    Expanded(
                      child: (commandes.isNotEmpty)
                          ? Padding(
                              padding: EdgeInsets.all(Dimensions.height8),
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: commandes.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    num total = commandes[index].total!;

                                    if (commandes[index].priceBase != 0) {
                                      total += commandes[index].priceBase!;
                                    }
                                    if (commandes[index]
                                            .priceTransportService !=
                                        0) {
                                      total += commandes[index]
                                          .priceTransportService!;
                                    }
                                    return InkWell(
                                      onTap: () => Get.to(
                                        DetailsOrder(
                                            user: widget.user,
                                            commande: commandes[index]),
                                      ),
                                      child: Card(
                                        child: ListTile(
                                          title: Text('#' +
                                              commandes[index].reference!),
                                          subtitle: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    Dimensions.height2),
                                                color: HexColor(commandes[index]
                                                    .status!
                                                    .color!),
                                                child: Text(
                                                  commandes[index]
                                                      .status!
                                                      .name!,
                                                  style: TextStyle(
                                                    color: MyThemes.whiteColor,
                                                    fontSize: Dimensions.font12,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Dimensions.width20,
                                              ),
                                              Text(total.toString() + ' FCFA'),
                                            ],
                                          ),
                                          leading: Icon(
                                            Icons.shopping_bag_outlined,
                                            size: Dimensions.iconSize32,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Center(
                              child: Padding(
                                padding: EdgeInsets.all(Dimensions.width20),
                                child: Text(
                                    "Vous n'avez aucune commande pour le moment"),
                              ),
                            ),
                    ),
                  ],
                )
              : CustomLoader();
        }));
  }
}
