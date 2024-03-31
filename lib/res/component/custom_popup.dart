import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/utils/asset/asset_name.dart';

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

 static void getWhiteDialog(BuildContext parent, ) {

   showDialog(
     context: parent,
     builder: (context) {
       return AlertDialog(
           backgroundColor: MyColors.activeTextColor,
           clipBehavior: Clip.antiAlias,
           content: Container(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Image.asset(AssetName.logoPng),
                 const SizedBox(height: 20,),
                 Text('Contact us', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),

                 MaterialButton(onPressed: ()=> Navigator.pop(context),
                 color: Color(0xff4D54FB),
                   child: Text('Ok', style: TextStyle(color: Colors.white, ),),
                 )

               ],
             ),
           )
       );
     },
   );
 }
}