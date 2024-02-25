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
    bool? home = bool.tryParse(inputData?['home']);
    bool? lock = bool.tryParse(inputData?['lock']);

    // You can call your function here
    await yourFunction(home, lock);

    return Future.value(true);
  });
}

Future<void> yourFunction(bool? home, bool? lock) async{
  bool homeValue = home??false;
  bool lockValue = lock??false;

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

  void register({required Duration duration,required bool home,required bool lock}) {
    final Map<String, dynamic> inputData = {
      'home': home,
      'lock': lock,
    };
    Workmanager().registerPeriodicTask(
      "1",
      "backgroundTask",
      initialDelay: duration,
      frequency: duration, // Adjust the frequency as needed
      inputData: inputData,
    );
  }

  void unregisterBackgroundTask() {
    Workmanager().cancelAll();
  }
}
