import 'package:hive/hive.dart';

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
  final int categoryId;

  @HiveField(4)
  final String categoryName;



  FavoriteItem(
      this.id, this.title, this.image, this.categoryId, this.categoryName,);
}