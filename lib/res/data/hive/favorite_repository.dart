

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';


class FavoriteRepository{
  final _boxName = 'favorite_item';

  static bool isListening = false;
  static int referenceCount = 0;
  Box<FavoriteItem>? box;

   Future<void> initialize()async{
    await Hive.initFlutter();

    // Register the adapter
    Hive.registerAdapter(FavoriteItemAdapter()); // Add this line
  }


  // Future<Box<FavoriteItem>> _openBox() async {
  //   if (!Hive.isBoxOpen(_boxName)) {
  //     return await Hive.openBox<FavoriteItem>(_boxName);
  //   } else {
  //     return Hive.box<FavoriteItem>(boxName);
  //   }
  // }


  Future<void> addFavoriteItem(FavoriteItem model) async {
    //final database = getIt<DatabaseHive>();
    await openFavoriteBox();
    await box!.put(model.id, model);
    await closeFavoriteBox();
  }

  Future<void> deleteFavoriteItem(int id) async {
    await openFavoriteBox();
    await box!.delete(id);
    await closeFavoriteBox();
  }

  Future<bool> hasParticularItem(int id)  async{
    await openFavoriteBox();

    final has =  box!.containsKey(id);
    await closeFavoriteBox();
    return has;
  }


  Future<FavoriteItem?> singleItem(int id) async {
    await openFavoriteBox();
    final item = box!.get(id);
    await closeFavoriteBox();
    return  item;
  }

  Future<List<FavoriteItem>> getAllFavorite() async{
    await openFavoriteBox();
    final items =  box!.values.toList();
    await closeFavoriteBox();
    return items;
  }

  Future<ValueListenable<Box<FavoriteItem>>> getListenable() async{
    await openFavoriteBox();
    return  box!.listenable();
  }



  Future<void> openFavoriteBox() async {
    // If the box is not open, open it
    if (referenceCount == 0 || !Hive.isBoxOpen(_boxName)) {
      box = await Hive.openBox(_boxName);
    }
    if (box==null || !box!.isOpen) {
      box = await Hive.openBox(_boxName);
    }
    // Increment the static reference count
    referenceCount++;
  }

  Future<void> closeFavoriteBox() async {
    // Decrement the static reference count
    referenceCount--;

    // If there are no more references, close the box
    if (referenceCount == 0 && box!=null) {
      await box!.close();
    }
  }

}