
import 'package:json_annotation/json_annotation.dart';

part 'all_wallpaper.g.dart';

@JsonSerializable()
class AllWallpaper {
  bool success;
  List<Wallpaper> data;

  AllWallpaper({
    required this.success,
    required this.data,
  });

  factory AllWallpaper.fromJson(Map<String, dynamic> json)=> _$AllWallpaperFromJson(json);
  Map<String, dynamic> toJson() => _$AllWallpaperToJson(this);

}

@JsonSerializable()
class Wallpaper {
  int id;
  String title;
  String image;
  String description;
  String tags;
  int like;

  @JsonKey(name: 'view_count')
  int viewCount;
  int download;
  @JsonKey(name: 'copyright_report')
  int copyrightReport;

  @JsonKey(name: 'user_id')
  int userId;
  Uploader uploader;
  List<Category> categories;
  bool likes;

  Wallpaper({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.tags,
    required this.like,
    required this.viewCount,
    required this.download,
    required this.copyrightReport,
    required this.userId,
    required this.uploader,
    required this.categories,
    required this.likes,
  });
  factory Wallpaper.fromJson(Map<String, dynamic> json) => _$WallpaperFromJson(json);
  Map<String, dynamic> toJson() => _$WallpaperToJson(this);
}

@JsonSerializable()
class Category {
  int id;
  String name;
  String? image;
  @JsonKey(name: 'display_name')
  String? displayName;
  @JsonKey(name: 'parent_category_id')
  int? parentCategoryId;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.displayName,
    required this.parentCategoryId,
  });
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}


@JsonSerializable()
class Uploader {
  int id;
  String name;
  String? image;
  int followers;
  int following;
  @JsonKey(name: 'followed_by_me')
  bool followedByMe;

  Uploader({
    required this.id,
    required this.name,
    required this.image,
    required this.followers,
    required this.following,
    required this.followedByMe,
  });
  factory Uploader.fromJson(Map<String, dynamic> json) => _$UploaderFromJson(json);
  Map<String, dynamic> toJson() => _$UploaderToJson(this);
}

