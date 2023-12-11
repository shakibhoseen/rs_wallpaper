// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_wallpaper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllWallpaper _$AllWallpaperFromJson(Map<String, dynamic> json) => AllWallpaper(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Wallpaper.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllWallpaperToJson(AllWallpaper instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

Wallpaper _$WallpaperFromJson(Map<String, dynamic> json) => Wallpaper(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      tags: json['tags'] as String,
      like: json['like'] as int,
      viewCount: json['view_count'] as int,
      download: json['download'] as int,
      copyrightReport: json['copyright_report'] as int,
      userId: json['user_id'] as int,
      uploader: Uploader.fromJson(json['uploader'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] as bool,
    );

Map<String, dynamic> _$WallpaperToJson(Wallpaper instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'description': instance.description,
      'tags': instance.tags,
      'like': instance.like,
      'view_count': instance.viewCount,
      'download': instance.download,
      'copyright_report': instance.copyrightReport,
      'user_id': instance.userId,
      'uploader': instance.uploader,
      'categories': instance.categories,
      'likes': instance.likes,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String?,
      displayName: json['display_name'] as String?,
      parentCategoryId: json['parent_category_id'] as int?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'display_name': instance.displayName,
      'parent_category_id': instance.parentCategoryId,
    };

Uploader _$UploaderFromJson(Map<String, dynamic> json) => Uploader(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String?,
      followers: json['followers'] as int,
      following: json['following'] as int,
      followedByMe: json['followed_by_me'] as bool,
    );

Map<String, dynamic> _$UploaderToJson(Uploader instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'followers': instance.followers,
      'following': instance.following,
      'followed_by_me': instance.followedByMe,
    };
