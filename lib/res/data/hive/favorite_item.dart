import 'package:hive/hive.dart';

import '../retrofit/model/all_wallpaper.dart' show Wallpaper;

part 'favorite_item.g.dart';

@HiveType(typeId: 0)
class FavoriteItem {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String fullImage;

  @HiveField(4)
  final int categoryId;

  @HiveField(5)
  final String categoryName;

  @HiveField(6)
  final CategoryItem categoryItem;


  FavoriteItem(
      this.id, this.title, this.image, this.fullImage, this.categoryId, this.categoryName, this.categoryItem);
}

@HiveType(typeId: 1)
class CategoryItem {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  @HiveField(3)
  final String displayName;

  @HiveField(4)
  final int parentCategoryId;


  CategoryItem(
      this.id, this.name, this.image, this.displayName, this.parentCategoryId, );
}


FavoriteItem convertFavoriteItem(Wallpaper wallpaper){
  final category = wallpaper.categories;
  return FavoriteItem(
    int.parse(wallpaper.id),
    wallpaper.title,
    wallpaper.image,
    wallpaper.fullImage,
    int.parse(wallpaper.categories?.id ?? '0'),
    wallpaper.categories?.name ?? 'none',
    category != null
        ? CategoryItem(category.id, category.name, category.image ?? '',
        category.displayName ?? '', 0)
        : CategoryItem('0', 'none', 'none', 'none', 0),
  );
}