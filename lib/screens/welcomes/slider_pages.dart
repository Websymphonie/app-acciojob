import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderPages extends StatelessWidget {
  final String title;
  final String description;
  String? image;
  SliderPages(
      {Key? key, required this.title, required this.description, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: MyThemes.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image.network(
              image!,
              width: width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: Dimensions.height50,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: Dimensions.font18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimensions.height20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Text(
              description,
              style: TextStyle(
                  height: 1.5,
                  fontSize: Dimensions.font14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.7),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Dimensions.height60,
          ),
        ],
      ),
    );
  }
}
