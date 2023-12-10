import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';

import 'res/utils/route/routes.dart';
import 'res/utils/route/routes_name.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
     MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: MyColors.canvasColor,
        shadowColor: Colors.white,
        scaffoldBackgroundColor: MyColors.canvasColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: MyColors.canvasColor),
        useMaterial3: true,
        fontFamily:  'Poppins',
      ),
       initialRoute: RoutesName.homeScreen,
       onGenerateRoute: Routes.generateRoute,
    );
 
  }
}