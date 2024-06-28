import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/utils/asset/asset_name.dart';

class CustomPopup {
  static void getPopUp(
    BuildContext context,
    Widget Function(BuildContext) childBuilder,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.green.withOpacity(0.14),
            clipBehavior: Clip.antiAlias,
            content: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 25, sigmaY: 25, tileMode: TileMode.mirror),
                child: childBuilder(context)));
      },
    );
  }

  static void getWhiteDialog(BuildContext parent,
      {String? title, Widget? content}) {
    showDialog(
      context: parent,
      builder: (context) {
        return AlertDialog(
          //backgroundColor: MyColors.activeTextColor,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Image.asset(AssetName.logoPng),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title ?? 'Contact us',
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 24),
                ),
                if (content != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: content,
                  ),
                Material(
                  child: InkWell(
                    onTap: () => Navigator.maybePop(context),
                    child: Ink(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        decoration: const BoxDecoration(
                          color: Color(0xff4D54FB),
                        ),
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'OK',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class DialogContentGenerator {
  final titleList = ['Contact Us', 'About Us'];

  (String, Widget) generate(int index) {
    if (index == 0) {
      return (titleList[0], contactWidget());
    }
    return (titleList[1], aboutWidget());
  }

  Widget contactWidget() {
    return Column(
      children: [
        const Text(
          'If you have any queries just'
          ' mail us we will replay '
          'you and please write your name also.',
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          text: const TextSpan(
              text: 'mail: ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: 'rsdesignerhub@gmail.com',
                    style: TextStyle(color: Colors.green)),
              ]),
        ),
      ],
    );
  }

  Widget aboutWidget() {
    return const Column(
      children: [
        Text(
          "A free app that has a large variety of unique "
          "and modern wallpapers and that has different "
          "categories to choose from.",
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          " We believe in"
          " quality rather than quantity.",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          " - Thousands "
          "of high-quality 4k logo collections"
          "for your screen.",
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
        Text(
          " - Wallpaper will fit according to "
          "your device screen.\n - Daily new updates will give you"
          " more options to customize.",
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
