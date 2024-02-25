import 'dart:ui';

import 'package:flutter/material.dart';

class CustomPopup{
 static void getPopUp(BuildContext context, Widget Function(BuildContext) childBuilder, ) {

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.green.withOpacity(0.14),
            clipBehavior: Clip.antiAlias,
            content: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 25, sigmaY: 25, tileMode: TileMode.mirror),
              child: childBuilder(context)
            ));
      },
    );
  }
}