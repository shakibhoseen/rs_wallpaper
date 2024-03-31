import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';

class HomePageDesign {
  static Widget listSelectUi(
      {required List<(String, String)> listString, required Function(String) onTap}) {
    final indexValue = ValueNotifier(0);

    return SizedBox(
      height: 40,
      child: ValueListenableBuilder(
          valueListenable: indexValue,
          builder: (context, value, _) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listString.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    indexValue.value = index;
                    onTap(listString[index].$2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      listString[index].$1,
                      style: value == index
                          ? const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: MyColors.activeTextColor)
                          : const TextStyle(color: MyColors.inactiveTextColor),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
