


part of 'common_event_state.dart';

class WallpaperFetchBloc
    extends Bloc<WallpaperFetchEvent, WallpaperFetchState> {
  late PageApiHolder _pageApiHolder;
  WallpaperFetchBloc()
      : _pageApiHolder = PageApiHolder(),
        super(WallpaperFetchInitial()) {
    on<WallpaperFetchPageEvent>((event, emit) async {
      try {

        if(!_pageApiHolder.hasData){
          Utils.showToastMessage('No more Wallpaper available..');
          throw BadRequestException('No more data');
        }

        if (!_pageApiHolder.hasComplete  ) {
         Utils.showToastMessage('Loading..');
         throw BadRequestException('Loading..');
        }

          _pageApiHolder = PageApiHolder.withIncreasedPage(_pageApiHolder);
        final page=  _pageApiHolder.page;
        Utils.showToastMessage('page is $page');
        emit(LoadingState());

        final allWallpaper =
            await _pageApiHolder._apiService.allWallpaper(page);
        emit(SuccessfulState(wallpaper: allWallpaper, page: page));
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
