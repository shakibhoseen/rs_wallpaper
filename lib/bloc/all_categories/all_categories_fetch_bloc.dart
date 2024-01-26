import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_categories.dart';

part 'all_categories_fetch_event.dart';
part 'all_categories_fetch_state.dart';

class AllCategoriesFetchBloc extends Bloc<AllCategoriesFetchEvent, AllCategoriesFetchState> {
  final ApiService _apiService;
  AllCategoriesFetchBloc() : _apiService=ApiService(Dio()) , super(AllCategoriesFetchInitial()) {
    on<AllCategoriesFetchEvent>((event, emit) async {
       try {
         final allCategory = await _apiService.allCategory();
         emit(SuccessfulState(allCategories: allCategory));
       } catch (e) {
          emit(ErrorState(error: e.toString()));
       }
    });
  }
}
