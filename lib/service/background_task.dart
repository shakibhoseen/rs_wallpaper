// background_task.dart

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/res/data/shared_pref/setting_datta.dart';
import 'package:rs_wallpaper/res/utils/operation_format.dart';
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
  final value = await SettingData().getSwitchValue();
  final  scren = value.$3;
  final itemHomeLock = OperationFormat.getBooleanFromScreenFormat(screenType: scren);
  bool homeValue = itemHomeLock.$1;
  bool lockValue = itemHomeLock.$2;
  print('home- $homeValue , lock- $lockValue');
  ScreenType v = ScreenType.homeScreen;

  if(homeValue && lockValue){
    v= ScreenType.bothScreen;
  }else if(lockValue){
    v = ScreenType.lockScreen;
  }


  // Your function logic goes here
  final random = Random();
  int page = random.nextInt(17);
  try{
    final allWallpaper = await ApiService(Dio()).allWallpaper(page);
    final list = allWallpaper.data;
    if(list.isNotEmpty){
      int index = random.nextInt(list.length);
      await setWallpaper(list[index].image, v );
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

  void register({required Duration duration,}) {

    Workmanager().registerPeriodicTask(
      "1",
      "backgroundTask",
      initialDelay: duration,
      frequency: duration, // Adjust the frequency as needed
    );
  }

  void unregisterBackgroundTask() {
    Workmanager().cancelAll();
  }
}
