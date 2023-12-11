part of 'wallpaper_fetch_bloc.dart';

@immutable
sealed class WallpaperFetchEvent {}

class WallpaperFetchPageEvent extends WallpaperFetchEvent {
  
  WallpaperFetchPageEvent();
}