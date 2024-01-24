import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rs_wallpaper/res/utils/utils.dart';
enum ScreenType{homeScreen, lockScreen, bothScreen}

class ServiceSetWallPaper{

  Future<bool> setWallpaper(String imageUrl, ScreenType screenType) async {
    try {
      // Check if the device supports wallpaper setting
      // bool isSetWallpaperAllowed = WallpaperManager. //await FlutterWallpaperManager.isSetWallpaperAllowed();
      // if (!isSetWallpaperAllowed) {
      //   // Handle the case where setting wallpaper is not allowed
      //   return;
      // }

      // Download the wallpaper image
      // You can use any image downloading package like `http` or `dio`
      // For simplicity, we'll assume you have the image bytes in a variable called `imageBytes`
      // final response = await http.get(Uri.parse(imageUrl), );
      // final imageBytes = response.bodyBytes;
      // final file = await createTemp('walpaper.jpg');
      // await file.writeAsBytes(imageBytes);

      print('before file given.');
      //final localFile = await getCachedFile(imageUrl);
      var file = await DefaultCacheManager().getSingleFile(imageUrl);

      if (file == null) {
        print('Error: Image not found in cache.');
        return false;
      }
      print('file is given');
      var type = WallpaperManager.BOTH_SCREEN;
      if(screenType== ScreenType.homeScreen){
        type = WallpaperManager.HOME_SCREEN;
      }else if(screenType == ScreenType.lockScreen){
        type = WallpaperManager.LOCK_SCREEN;
      }

      // Set wallpaper from bytes
      final result = await WallpaperManager.setWallpaperFromFile(
       file.path
      , type);
      print(' setting wallpaper: $result');
      return result;
    } catch (e) {
      // Handle exceptions
      print('Error setting wallpaper: $e');
      return false;
    }
  }

}


Future<File> createTemp(String filename) async {
  final tempDir = Directory.systemTemp;
  final tempFile = File('${tempDir.path}/$filename');

  // Check if the file exists, and delete it if it does
  if (tempFile.existsSync()) {
    tempFile.deleteSync();
  }

  await tempFile.create(recursive: true);
  return tempFile;
}