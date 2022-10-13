import 'package:acciojob/services/models/services/service.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class InfosServiceScreen extends StatefulWidget {
  final Service service;
  final UserModel? user;

  const InfosServiceScreen(
      {Key? key, required this.service, required this.user})
      : super(key: key);

  @override
  State<InfosServiceScreen> createState() => _InfosServiceScreenState();
}

class _InfosServiceScreenState extends State<InfosServiceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(
            label: widget.service.name!, textOverflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(
              Icons.search,
              color: MyThemes.blackColor,
              size: Dimensions.iconSize24,
            ),
          )
        ],
        titleTextStyle: TextStyle(
          fontSize: Dimensions.height15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      backgroundColor: MyThemes.creamColor,
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height7),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Html(
                  data: widget.service.description,
                  style: {
                    "h3 > span": Style(fontSize: FontSize(Dimensions.font12)),
                    "p > span": Style(
                      fontSize: FontSize(Dimensions.font12),
                      textAlign: TextAlign.justify,
                    ),
                  },
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                Html(
                  data: widget.service.content,
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
