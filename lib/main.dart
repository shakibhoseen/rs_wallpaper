
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:rs_wallpaper/service/background_task.dart';
import 'package:rs_wallpaper/service/service_locator.dart';

import 'app.dart';
// @pragma(
//     'vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     // Your periodic task logic goes here
//     print("Background task is running!");
//
//     // You can call your function here
//     yourFunction();
//
//     return Future.value(true);
//   });
// }
//
// void yourFunction() {
//   // Your function logic goes here
//   print("Your function is called 23!");
// }


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  // await Workmanager().initialize(
  //   callbackDispatcher,
  // );
  await BackgroundTask().initialize();
  await setupServiceLocator();
  // await Workmanager().registerPeriodicTask(
  //   "daily_wallpaper_task",
  //   "task_tag",
  //   initialDelay: const Duration(seconds: 5), // Adjust for testing
  //   frequency: const Duration(seconds: 15),
  // );
  runApp(const MyApp());
}


// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     ServiceSetWallPaper wallPaper = ServiceSetWallPaper();
//     await wallPaper.setWallpaper('https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80');
//     return Future.value(true);
//   });
// }
