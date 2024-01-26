

part of 'common_event_state.dart';

class WallpaperByCategoryBloc
    extends Bloc<WallpaperFetchEvent, WallpaperFetchState> {
  late PageApiHolder _pageApiHolder;
  WallpaperByCategoryBloc()
      : _pageApiHolder = PageApiHolder(),
        super(WallpaperFetchInitial()) {
    on<WallpaperByCategoryEvent>((event, emit) async {
      try {



        emit(LoadingState());

        final allWallpaper =
            await _pageApiHolder._apiService.categoryWallpaper('${event.categoryId}', '');
        emit(SuccessfulState(wallpaper: allWallpaper, page: 1));


      } catch (e) {
        emit(ErrorState(error: e.toString()));
      }
    });
  }
}
