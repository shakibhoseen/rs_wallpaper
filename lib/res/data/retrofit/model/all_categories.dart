import 'package:json_annotation/json_annotation.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';

part 'all_categories.g.dart';

@JsonSerializable()
class AllCategories {
  bool success;
  List<Category> data;

  AllCategories({
    required this.success,
    required this.data,
  });

  factory AllCategories.fromJson(Map<String, dynamic> json)=> _$AllCategoriesFromJson(json);
  Map<String, dynamic> toJson() => _$AllCategoriesToJson(this);

}