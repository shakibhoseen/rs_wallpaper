import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/my_shadow.dart';

import 'res/utils/route/routes.dart';
import 'res/utils/route/routes_name.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(

        appBarTheme: const AppBarTheme(backgroundColor: MyColors.canvasColor, iconTheme:  IconThemeData(color: MyColors.activeTextColor), shadowColor: Colors.white30 ),
        canvasColor: MyColors.canvasColor,
        shadowColor: Colors.white,
        iconTheme:  const IconThemeData(color: MyColors.activeTextColor),
        scaffoldBackgroundColor: MyColors.canvasColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: MyColors.canvasColor),
        useMaterial3: true,
        fontFamily:  'Poppins',
      ),
       initialRoute: RoutesName.splashScreen,
       onGenerateRoute: Routes.generateRoute,
    );
 
  }
}