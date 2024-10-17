import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/asset/asset_name.dart';

extension FutureDialogExtension<T> on Future<T> {
  Future<T?> showWithDialog(BuildContext context, {String? message}) async {
    // Show the loading dialog
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.green.withOpacity(0.14),
            clipBehavior: Clip.antiAlias,
            content: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 25, sigmaY: 25, tileMode: TileMode.mirror),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AssetName.loadingGif,
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                   Text(
                    message?? 'Processing...',
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ));
      },
    );

    T? result;
    try {
      result = await this; // Await the future
    } finally {
      // Dismiss the dialog
      if(context.mounted) {
        Navigator.of(context).pop();
      }
    }
    return result;
  }
}
