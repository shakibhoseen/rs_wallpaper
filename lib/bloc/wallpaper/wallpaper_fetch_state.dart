part of 'common_event_state.dart';

@immutable
sealed class WallpaperFetchState {}

final class WallpaperFetchInitial extends WallpaperFetchState {}

final class LoadingState extends WallpaperFetchState {}

class SuccessfulState extends WallpaperFetchState {
  final AllWallpaper wallpaper;
  final int page;
  SuccessfulState({required this.wallpaper, required this.page});

}

class ErrorState extends WallpaperFetchState {
  final String error;

  ErrorState({required this.error});

}
