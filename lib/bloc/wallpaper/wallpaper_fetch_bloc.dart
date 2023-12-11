// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';

import '../../res/data/app_exceptions.dart';

part 'wallpaper_fetch_event.dart';
part 'wallpaper_fetch_state.dart';

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

class PageApiHolder {
  final int _page;
  final ApiService _apiService;
  final bool _isCompleteFetch;
  final bool _hasMore;
  PageApiHolder({int page = 0})
      : _apiService = ApiService(Dio()),
        _page = page, _isCompleteFetch = true, _hasMore = true;

  PageApiHolder.withIncreasedPage(PageApiHolder original)
      : _apiService = original._apiService,
        _page = original._page + 1,
        _isCompleteFetch = false, _hasMore = true;

  PageApiHolder.withCompletePage(PageApiHolder original)
      : _apiService = original._apiService,
        _page = original._page,
        _isCompleteFetch = true, _hasMore = true;

  PageApiHolder.withNoMorePage(PageApiHolder original)
      : _apiService = original._apiService,
        _page = original._page,
        _isCompleteFetch = true,
        _hasMore = false;


  int get page => _page;

  bool get hasComplete => _isCompleteFetch;
  bool get hasData => _hasMore;

  ApiService get apiService => _apiService;
}
