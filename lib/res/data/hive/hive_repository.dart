

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';


class HiveRepository{
   final boxName = 'download_item';
   //Box<FavoriteItem>? box;


  static Future<void> initialize()async{
    await Hive.initFlutter();

    // Register the adapter
    Hive.registerAdapter(FavoriteItemAdapter()); // Add this line
  }


   Future<Box<FavoriteItem>> _openBox() async {
     if (!Hive.isBoxOpen(boxName)) {
       return await Hive.openBox<FavoriteItem>(boxName);
     } else {
       return Hive.box<FavoriteItem>(boxName);
     }
   }


  Future<void> addFavoriteItem(FavoriteItem model) async {
    //final database = getIt<DatabaseHive>();
    final box = await _openBox();
    await box.put(model.id, model);
    await box.close();
  }

  Future<void> deleteFavoriteItem(int id) async {
    final box = await _openBox();
    await box.delete(id);
    await box.close();
  }

   Future<bool> hasParticularItem(int id)  async{
     final box = await _openBox();

      final has =  box.containsKey(id);
     await box.close();
     return has;
   }


   Future<FavoriteItem?> singleItem(int id) async {
     final box = await _openBox();
     final item = box.get(id);
     await box.close();
     return  item;
   }

   Future<List<FavoriteItem>> getAllFavorite() async{
     Box<FavoriteItem> box = await _openBox();
     final items =  box.values.toList();
     await box.close();
     return items;
   }

}