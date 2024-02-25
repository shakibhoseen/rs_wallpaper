import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';


class DownloadRepository {
  static const _boxName = 'download';
  final limit = 4;
  static bool isListening = false;
  static int referenceCount = 0;
  Box<FavoriteItem>? box;

  Future<void> addDownloadItem(FavoriteItem model) async {
    // final database = getIt<DatabaseHive>();
    // int limit= await database.getRecentSongLimit();
    await openDownloadItemBox();


    // Remove the oldest song if the list exceeds the limit

    final len = box!.length;
    if (len >= limit) {
       final oldItems = box!.values.toList();

       int songsToRemove = len - limit+1;
      for (int i = 0; i < songsToRemove; i++) {
        box!.delete(oldItems[i].id);
      }
    //
     }
    //
    // // Add the recent song to the list
     await box!.put(model.id, model);
     await closeDownloadItemBox();
  }

  Future<List<FavoriteItem>> getDownloadItem() async {
    await openDownloadItemBox();
    final recentSongs = box!.values.toList();

    await closeDownloadItemBox();
    return recentSongs;
  }

  Future<ValueListenable<Box<FavoriteItem>>> getListenable() async{
    await openDownloadItemBox();
    return  box!.listenable();
  }



  Future<void> openDownloadItemBox() async {
    // If the box is not open, open it
    if (referenceCount == 0) {
      box = await Hive.openBox(_boxName);
    }
    if (box==null || !box!.isOpen) {
      box = await Hive.openBox(_boxName);
    }
    // Increment the static reference count
    referenceCount++;
  }

  Future<void> closeDownloadItemBox() async {
    // Decrement the static reference count
    referenceCount--;

    // If there are no more references, close the box
    if (referenceCount == 0 && box!=null) {
      await box!.close();
    }
  }
  Future<bool> hasParticularItem(int id)  async{
    await openDownloadItemBox();

    final has =  box!.containsKey(id);
    await closeDownloadItemBox();
    return has;
  }
  Future<void> deleteDownloadItem(int id) async {
    await openDownloadItemBox();
    await box!.delete(id);
    await closeDownloadItemBox();
  }
}
