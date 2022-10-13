import 'package:acciojob/services/models/children.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget {
  final Children? service;
  ServicePage({Key? key, required this.service}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.pageViewWrap,
      child: PageView.builder(
          controller: pageController,
          itemCount: 1,
          itemBuilder: (context, index) {
            return _buildPageItem(index);
          }),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Hero(
          tag: Key(widget.service!.id.toString()),
          child: Container(
            height: height,
            margin: EdgeInsets.only(
              left: Dimensions.width5,
              right: Dimensions.width5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: index.isEven ? MyThemes.primaryColor : MyThemes.creamColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  AppConstants.IMAGE_URL_SERVICE + (widget.service!.filename!),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: Dimensions.height20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color: MyThemes.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 3.0,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  left: Dimensions.width15,
                  right: Dimensions.width15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Wrap(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: BigText(
                              text: widget.service!.name!,
                              size: Dimensions.font16,
                              maxlines: 2,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
