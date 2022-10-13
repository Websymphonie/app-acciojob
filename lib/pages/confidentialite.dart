import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/services/controllers/page_static_controller.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:acciojob/widgets/drawer.dart';
import 'package:acciojob/widgets/home_button.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class Confidentialite extends StatefulWidget {
  const Confidentialite({Key? key}) : super(key: key);

  @override
  State<Confidentialite> createState() => _ConfidentialiteState();
}

class _ConfidentialiteState extends State<Confidentialite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(label: 'Confidentialité'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: HomeButton(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: GetBuilder<PageStaticController>(builder: (page) {
            var data = page.page;
            return page.isLoaded
                ? Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        BigText(
                          text: data.name!,
                          size: Dimensions.font22,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Html(
                          data: data.content,
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
