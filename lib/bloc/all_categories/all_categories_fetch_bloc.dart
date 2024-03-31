import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_categories.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'all_categories_fetch_event.dart';
part 'all_categories_fetch_state.dart';

class AllCategoriesFetchBloc extends Bloc<AllCategoriesFetchEvent, AllCategoriesFetchState> {
  final ApiService _apiService;
  final List<Category> categories=[];
  AllCategoriesFetchBloc() : _apiService=ApiService(Dio()) , super(AllCategoriesFetchState.initial()) {
    on<AllCategoriesFetchEventInit>((event, emit) async {
       try {
         emit(AllCategoriesFetchState.loading());
         final allCategory = await _apiService.allCategory();
         log('call new categories....................................');
         categories.addAll(allCategory.data);
         emit(AllCategoriesFetchState.success(allCategory));
       } catch (e) {
          emit(AllCategoriesFetchState.error( e.toString()));
       }
    });
    on<LoadOldCategoriesEvent>((event, emit) => emit(AllCategoriesFetchState.oldData(categories)));
  }
}
