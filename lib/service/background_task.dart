// background_task.dart

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/service/service_set_wallpaper.dart';
import 'package:workmanager/workmanager.dart';

@pragma(
    'vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData)async {
    // Your periodic task logic goes here

    // You can call your function here
    await yourFunction();

    return Future.value(true);
  });
}

Future<void> yourFunction() async{
  // Your function logic goes here
  final random = Random();
  int page = random.nextInt(17);
  try{
    final allWallpaper = await ApiService(Dio()).allWallpaper(page);
    final list = allWallpaper.data;
    if(list.isNotEmpty){
      int index = random.nextInt(list.length);
      await setWallpaper(list[index].image, ScreenType.homeScreen );
    }
  }catch(e){//
  }


}

Future<void> setWallpaper(String url, ScreenType screenType,) async{
  ServiceSetWallPaper wallpaper = ServiceSetWallPaper();
   await wallpaper.setWallpaper(url, screenType);
  }


class BackgroundTask {
  Future<void> initialize() async{
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  void register() {
    Workmanager().registerPeriodicTask(
      "1",
      "backgroundTask",
      initialDelay: const Duration(minutes: 15),
      frequency: const Duration(minutes: 15), // Adjust the frequency as needed
    );
  }

  void unregisterBackgroundTask() {
    Workmanager().cancelAll();
  }
}
