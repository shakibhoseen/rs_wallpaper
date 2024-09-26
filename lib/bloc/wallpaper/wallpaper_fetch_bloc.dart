part of 'common_event_state.dart';

class WallpaperFetchBloc
    extends Bloc<WallpaperFetchEvent, WallpaperFetchState> {
  late PageApiHolder _pageApiHolder;
  Map<String, (List<Wallpaper>, PageApiHolder)> wallpaperIndex = {};
  WallpaperFetchBloc()
      : _pageApiHolder = PageApiHolder(),
        super(WallpaperFetchInitial()) {
    on<WallpaperByCategoryEvent>((event, emit) async {
      try {
        int id = event.categoryId;

        if (wallpaperIndex.containsKey('$id')) {
          //final p = wallpaperIndex[id]?.$1?? [];
          _pageApiHolder = wallpaperIndex['$id']?.$2 ?? PageApiHolder();
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

        final allWallpaper = id >= 0
            ? await _pageApiHolder._apiService
                .categoryWallpaper('${event.categoryId}', page)
            : await _pageApiHolder._apiService.allWallpaper(page);
        //wallpaperIndex;

        /// set page length for background wallpaper
        if (id == -1) {
          int pageLength = await SettingData().getPageLength();
          if (pageLength == 0 ||
              pageLength != int.tryParse(allWallpaper.pagination.totalRows)) {
            final total = int.tryParse(allWallpaper.pagination.totalRows);
            if (total != null) {
              SettingData().setPageLength(pageLength: total);
            }
          }
        }

        emit(SuccessfulState(wallpaper: allWallpaper, page: page));
        if (allWallpaper.data.isNotEmpty) {
          _pageApiHolder = PageApiHolder.withCompletePage(_pageApiHolder);
        } else {
          _pageApiHolder = PageApiHolder.withNoMorePage(_pageApiHolder);
        }

        if (wallpaperIndex.containsKey('$id')) {
          wallpaperIndex['$id'] = (
            [...wallpaperIndex['$id']?.$1 ?? [], ...allWallpaper.data],
            _pageApiHolder
          );
        } else {
          //new
          wallpaperIndex['$id'] = (allWallpaper.data, _pageApiHolder);
        }
      } catch (e) {
        emit(ErrorState(error: e.toString()));
      }
    });

    on<WallpaperLoadOldDataEvent>((event, emit) {
      emit(LoadOldDataState(
          data: wallpaperIndex['${event.categoryId}']?.$1 ?? []));
    });
  }
}
