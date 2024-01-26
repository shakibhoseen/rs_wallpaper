// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:meta/meta.dart';

import '../../res/data/retrofit/model/all_wallpaper.dart';


import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../res/data/app_exceptions.dart';
import '../../res/data/retrofit/api_retrofit.dart';
import '../../res/utils/utils.dart';


part 'wallpaper_fetch_event.dart';
part 'wallpaper_fetch_state.dart';

part 'wallpaper_fetch_bloc.dart';
part 'wallpaper_by_category_bloc.dart';

class CommonEventState{

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
