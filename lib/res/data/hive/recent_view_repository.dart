import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';


class RecentViewRepository {
  static const _boxName = 'recent_view';
  final limit = 4;
  static bool isListening = false;
  static int referenceCount = 0;
  Box<FavoriteItem>? box;

  Future<void> addRecentItem(FavoriteItem model) async {
    // final database = getIt<DatabaseHive>();
    // int limit= await database.getRecentSongLimit();
    await openRecentSongsBox();


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
     await closeRecentSongsBox();
  }

  Future<List<FavoriteItem>> getRecentItem() async {
    await openRecentSongsBox();
    final recentSongs = box!.values.toList();

    await closeRecentSongsBox();
    return recentSongs;
  }

  Future<ValueListenable<Box<FavoriteItem>>> getListenable() async{
    await openRecentSongsBox();
    return  box!.listenable();
  }



  Future<void> openRecentSongsBox() async {
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

  Future<void> closeRecentSongsBox() async {
    // Decrement the static reference count
    referenceCount--;

    // If there are no more references, close the box
    if (referenceCount == 0 && box!=null) {
      await box!.close();
    }
  }
  Future<bool> hasParticularItem(int id)  async{
    await openRecentSongsBox();

    final has =  box!.containsKey(id);
    await closeRecentSongsBox();
    return has;
  }
  Future<void> deleteFavoriteItem(int id) async {
    await openRecentSongsBox();
    await box!.delete(id);
    await closeRecentSongsBox();
  }
}
