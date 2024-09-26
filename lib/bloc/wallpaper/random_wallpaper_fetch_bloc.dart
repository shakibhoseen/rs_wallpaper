part of 'common_event_state.dart';

class RandomWallpaperFetchBloc
    extends Bloc<WallpaperFetchEvent, WallpaperFetchState> {
  late PageApiHolder _pageApiHolder;
  Map<String, (List<Wallpaper>, PageApiHolder)> wallpaperIndex = {};
  RandomWallpaperFetchBloc()
      : _pageApiHolder = PageApiHolder(),
        super(WallpaperFetchInitial()) {
    on<WallpaperFetchPageEvent>((event, emit) async {
      try {
        //int id = event.categoryId;

        if (wallpaperIndex.containsKey(Constant.randomKey)) {
          //final p = wallpaperIndex[id]?.$1?? [];
          _pageApiHolder = wallpaperIndex[Constant.randomKey]?.$2 ?? PageApiHolder();
        } else {
          _pageApiHolder = PageApiHolder();
        }

        if (!_pageApiHolder.hasData) {
          Utils.showToastMessage('No more Wallpaper available..');
          return;
        }

        if (!_pageApiHolder.hasComplete) {
          Utils.showToastMessage('Loading..');
          return;
        }

        _pageApiHolder = PageApiHolder.withIncreasedPage(_pageApiHolder);
        final page = _pageApiHolder.page;
        //Utils.showToastMessage('page is $page');
        emit(LoadingState());

        final allWallpaper = await _pageApiHolder._apiService.randomWallpaper(page);
        //wallpaperIndex;

        /// set page length for background wallpaper
        // if (id == -1) {
        //   int pageLength = await SettingData().getPageLength();
        //   if (pageLength == 0 ||
        //       pageLength != int.tryParse(allWallpaper.pagination.totalRows)) {
        //     final total = int.tryParse(allWallpaper.pagination.totalRows);
        //     if (total != null) {
        //       SettingData().setPageLength(pageLength: total);
        //     }
        //   }
        // }

        emit(SuccessfulState(wallpaper: allWallpaper, page: page));
        if (allWallpaper.data.isNotEmpty) {
          _pageApiHolder = PageApiHolder.withCompletePage(_pageApiHolder);
        } else {
          _pageApiHolder = PageApiHolder.withNoMorePage(_pageApiHolder);
        }

        if (wallpaperIndex.containsKey(Constant.randomKey)) {
          wallpaperIndex[Constant.randomKey] = (
            [...wallpaperIndex[Constant.randomKey]?.$1 ?? [], ...allWallpaper.data],
            _pageApiHolder
          );
        } else {
          //new
          wallpaperIndex[Constant.randomKey] = (allWallpaper.data, _pageApiHolder);
        }
      } catch (e) {
        emit(ErrorState(error: e.toString()));
      }
    });

    on<WallpaperLoadOldDataEvent>((event, emit) {
      emit(LoadOldDataState(
          data: wallpaperIndex[Constant.randomKey]?.$1 ?? []));
    });
  }
}
