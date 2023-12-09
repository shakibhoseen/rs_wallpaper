import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum FlashType { error, success }

class Utils {

  static fieldFocusChanged(
      BuildContext context,
      FocusNode currentNode,
      FocusNode nextNode,
      ){
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static showFlashBarMessage(
      String message, FlashType type, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          title: type == FlashType.success ? "Success" : "Error",
          icon: Icon(
            type == FlashType.success ? Icons.thumb_up : Icons.error,
            color: Colors.white,
          ),
          message: message,
          backgroundColor: type == FlashType.success ? Colors.green : Colors.red,
          titleColor: Colors.white,
          messageColor: Colors.white,
          duration: const Duration(seconds: 2),
        )..show(context));
  }
}
