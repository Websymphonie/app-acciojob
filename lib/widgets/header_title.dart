import 'package:flutter/material.dart';

import 'package:acciojob/utils/themes.dart';

// ignore: must_be_immutable
class HeaderTitle extends StatefulWidget {
  String title;
  String subtitle;
  double? size;
  HeaderTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    this.size = 23.0,
  }) : super(key: key);

  @override
  State<HeaderTitle> createState() => _HeaderTitleState();
}

class _HeaderTitleState extends State<HeaderTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: MyThemes.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: widget.size,
          ),
        ),
        Text(widget.subtitle),
      ],
    );
  }
}
