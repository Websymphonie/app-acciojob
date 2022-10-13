import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/services/controllers/contact_controller.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:acciojob/widgets/drawer.dart';
import 'package:acciojob/widgets/home_button.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(label: 'Contactez-Nous'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: HomeButton(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: GetBuilder<ContactController>(builder: (contact) {
            var data = contact.contact;
            return contact.isLoaded
                ? Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Dimensions.height30,
                          ),
                          data.description != null
                              ? Html(
                                  data: data.description,
                                )
                              : Container(),
                          data.email != null
                              ? BigText(text: data.email!)
                              : Container(),
                          data.email != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.telephone != null
                              ? BigText(text: data.telephone!)
                              : Container(),
                          data.telephone != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.cellulaire != null
                              ? BigText(text: data.cellulaire!)
                              : Container(),
                          data.cellulaire != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.facebook != null
                              ? BigText(
                                  text: data.facebook!,
                                  size: Dimensions.font13,
                                )
                              : Container(),
                          data.facebook != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.twitter != null
                              ? BigText(
                                  text: data.twitter!,
                                  size: Dimensions.font13,
                                )
                              : Container(),
                          data.twitter != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.linkedin != null
                              ? BigText(
                                  text: data.linkedin!,
                                  size: Dimensions.font13,
                                )
                              : Container(),
                          data.linkedin != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.youtube != null
                              ? BigText(
                                  text: data.youtube!,
                                  size: Dimensions.font13,
                                )
                              : Container(),
                          data.youtube != null
                              ? SizedBox(
                                  height: Dimensions.height10,
                                )
                              : Container(),
                          data.adresses != null
                              ? Html(
                                  data: data.adresses,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  )
                : CustomLoader();
          }),
        ),
      ),
    );
  }
}
