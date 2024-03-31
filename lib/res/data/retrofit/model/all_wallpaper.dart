
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
  String id;
  String title;
  String image;
  @JsonKey(name: 'fullimage')
  String fullImage;
  //String description;
  String? tags;
  //int like;

  @JsonKey(name: 'views')
  String? viewCount;
  String? download;
  String? upload;
  // @JsonKey(name: 'copyright_report')
  // int copyrightReport;

  @JsonKey(name: 'user_id')
  String? userId;
  Uploader? uploader;
  Category? categories;
  //bool likes;

  Wallpaper({
    required this.id,
    required this.title,
    required this.image,
    //required this.description,
     this.tags,
    //required this.like,
     this.viewCount,
     this.download,
    //required this.copyrightReport,
     this.userId,
     this.uploader,
     this.categories,
    required this.fullImage,
     this.upload,
    //required this.likes,
  });
  factory Wallpaper.fromJson(Map<String, dynamic> json) => _$WallpaperFromJson(json);
  Map<String, dynamic> toJson() => _$WallpaperToJson(this);
}

@JsonSerializable()
class Category {
  String id;
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
  String id;
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

