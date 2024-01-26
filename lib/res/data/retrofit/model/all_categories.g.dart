// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllCategories _$AllCategoriesFromJson(Map<String, dynamic> json) =>
    AllCategories(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllCategoriesToJson(AllCategories instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
