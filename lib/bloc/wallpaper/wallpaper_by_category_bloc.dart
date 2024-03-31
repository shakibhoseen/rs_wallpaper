

part of 'common_event_state.dart';

class WallpaperByCategoryBloc
    extends Bloc<WallpaperFetchEvent, WallpaperFetchState> {
  late PageApiHolder _pageApiHolder;
  final List<(List<Wallpaper>, PageApiHolder)> wallpaperIndex = [];
  WallpaperByCategoryBloc()
      : _pageApiHolder = PageApiHolder(),
        super(WallpaperFetchInitial()) {
    on<WallpaperByCategoryEvent>((event, emit) async {
      try {

        if(!_pageApiHolder.hasData){
          Utils.showToastMessage('No more Wallpaper available..');
          return;
          throw BadRequestException('No more data');
        }

        if (!_pageApiHolder.hasComplete  ) {
          Utils.showToastMessage('Loading..');
          return;
          throw BadRequestException('Loading..');
        }
        _pageApiHolder = PageApiHolder.withIncreasedPage(_pageApiHolder);
        final page=  _pageApiHolder.page;

        emit(LoadingState());

        final allWallpaper =
            await _pageApiHolder._apiService.categoryWallpaper('${event.categoryId}', page);
        emit(SuccessfulState(wallpaper: allWallpaper, page: 1));

        if( allWallpaper.data.isNotEmpty){
          _pageApiHolder = PageApiHolder.withCompletePage(_pageApiHolder);
        }else{
          _pageApiHolder = PageApiHolder.withNoMorePage(_pageApiHolder);
        }

      } catch (e) {
        emit(ErrorState(error: e.toString()));
      }
    });
  }
}
