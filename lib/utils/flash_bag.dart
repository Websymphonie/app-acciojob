import 'package:flutter/material.dart';
import 'package:flash/flash.dart';

class FlashBag {
  void flash(
      context, int duration, List<Color> colors, String title, String message) {
    showFlash(
      context: context,
      duration: Duration(seconds: duration),
      builder: (context, controller) {
        return Flash.bar(
          controller: controller,
          backgroundGradient: LinearGradient(
            colors: colors,
          ),
          position: FlashPosition.bottom,
          enableVerticalDrag: true,
          horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          margin: EdgeInsets.all(8.0),
          forwardAnimationCurve: Curves.easeInBack,
          reverseAnimationCurve: Curves.slowMiddle,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: FlashBar(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            primaryAction: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            icon: Icon(
              Icons.info_rounded,
              color: Colors.white,
            ),
            shouldIconPulse: false,
            showProgressIndicator: true,
          ),
        );
      },
    );
  }
}
