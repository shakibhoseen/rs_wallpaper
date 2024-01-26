part of 'common_event_state.dart';


@immutable
sealed class WallpaperFetchEvent {}

class WallpaperFetchPageEvent extends WallpaperFetchEvent {
  
  WallpaperFetchPageEvent();
}

class WallpaperByCategoryEvent extends WallpaperFetchEvent {
  final int categoryId;
  WallpaperByCategoryEvent({required this.categoryId});
}