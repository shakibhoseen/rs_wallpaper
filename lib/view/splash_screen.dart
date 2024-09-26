import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';

import '../res/utils/route/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void loading(BuildContext context)async {
    Future.delayed(
      const Duration(seconds: 2),
      (){
        Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    loading(context);
    return Scaffold(
      body: Lottie.asset('assets/rs.json'),
    );
  }
}
