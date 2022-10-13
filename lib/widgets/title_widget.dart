import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String label;
  final Color? color;
  final int? maxLines;
  final TextOverflow? textOverflow;
  const TitleWidget(
      {Key? key,
      required this.label,
      this.color,
      this.maxLines = 1,
      this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color ?? Colors.black,
        fontSize: Dimensions.font15,
        fontWeight: FontWeight.bold,
      ),
      maxLines: maxLines,
      overflow:
          textOverflow != null ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}
