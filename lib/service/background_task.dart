// background_task.dart

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/service/service_set_wallpaper.dart';
import 'package:rs_wallpaper/view/screen/display_wallpaper_screen.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData)async {
    // Your periodic task logic goes here
    print("Background task is running!");

    // You can call your function here
    await yourFunction();

    return Future.value(true);
  });
}

Future<void> yourFunction() async{
  // Your function logic goes here
  final random = Random();
  int page = random.nextInt(17);
  print("Your function first!");
  try{
    final allWallpaper = await ApiService(Dio()).allWallpaper(page);
    final list = allWallpaper.data;
    print('all wallpaper is fetches ');
    if(list.length>0){
      int index = random.nextInt(list.length);
      print('all wallpaper index is $index ');
      await setWallpaper(list[index].image, ScreenType.homeScreen );
      print('after set wallpaper');
    }
    print('outside call wallpaper');
  }catch(e){
    print(e.toString());
  }


  print("Your function is uuu called!");
}

Future<void> setWallpaper(String url, ScreenType screenType,) async{
  ServiceSetWallPaper wallpaper = ServiceSetWallPaper();
   await wallpaper.setWallpaper(url, screenType);
  }


class BackgroundTask {
  Future<void> initialize() async{
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  void register() {
    Workmanager().registerPeriodicTask(
      "1",
      "backgroundTask",
      frequency: Duration(minutes: 15), // Adjust the frequency as needed
    );
  }

  void unregisterBackgroundTask() {
    Workmanager().cancelAll();
  }
}
