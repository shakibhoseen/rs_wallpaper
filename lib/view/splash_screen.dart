import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:lottie/lottie.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';

import '../res/utils/route/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        loading(context);
      }
    },);

    super.initState();
  }

  void loading(BuildContext context)async {
    Future.delayed(
      const Duration(seconds: 1),
      (){
        if(context.mounted) {
          Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
        }
      }
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    loading(context);
    return Scaffold(
      body: Lottie.asset('assets/rs.json', controller: _controller,
        onLoaded: (composition) {
        // Configure the AnimationController with the duration of the
        // Lottie file and start the animation.
        _controller
          ..duration = composition.duration
          ..forward();
      },),
    );
  }




}
