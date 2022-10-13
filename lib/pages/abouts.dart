import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/services/controllers/about_controller.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:acciojob/widgets/drawer.dart';
import 'package:acciojob/widgets/home_button.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(label: 'Qui sommes nous?'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: HomeButton(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: GetBuilder<AboutController>(builder: (about) {
            var data = about.about;
            return about.isLoaded
                ? Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        data.name != null
                            ? BigText(
                                text: data.name!,
                                size: Dimensions.font22,
                              )
                            : Container(),
                        Html(
                          data: data.description,
                        ),
                      ],
                    ),
                  )
                : CustomLoader();
          }),
        ),
      ),
    );
  }
}
