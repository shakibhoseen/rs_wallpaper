
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';


import 'model/all_categories.dart';
import 'model/all_wallpaper.dart';

part "api_retrofit.g.dart";


@RestApi(baseUrl: "https://gdgtverse.com/api/wallpaper/") // replace with your base URL
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;



  @GET("all")
  Future<AllWallpaper> allWallpaper(@Query("page") int page);

  @GET("wallpaper/all")
  Future<AllWallpaper> allWallpaperWithToken(
    @Header("Authorization") String token,
    @Query("user_id") String id,
    @Query("page") int page,
  );

  @GET("trending")
  Future<AllWallpaper> trendingWallpaper(@Query("page") int page);

  @GET("wallpaper/trending")
  Future<AllWallpaper> trendingWallpaperWithToken(
    @Header("Authorization") String token,
    @Query("user_id") String id,
    @Query("page") int page,
  );

  @GET("wallpaper/search")
  Future<AllWallpaper> searchWallpaper(
    @Query("tag") String tag,
    @Query("page") int page,
  );

  @GET("wallpaper/search")
  Future<AllWallpaper> searchWallpaperWithToken(
    @Header("Authorization") String token,
    @Query("user_id") String id,
    @Query("tag") String tag,
    @Query("page") int page,
  );

   @GET("catapi/1") // use a  category
   Future<AllCategories> allCategory();

  @GET("scatapi") // category by wallpaper
  Future<AllWallpaper> categoryWallpaper(
      @Query("id") String id,
      @Query("page") int page,
      );


    // Handle the response and potential errors
  static handleResponse<T>(Response<T> response) {
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  // Common method for making API calls and handling errors
  static Future<T> execute<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (e) {
      if (e is DioException) {
        print('DioError: ${e.message}');
        print('Status code: ${e.response?.statusCode}');
      } else {
        print('Error: $e');
      }
      rethrow; // Rethrow the error to allow higher-level error handling
    }
  }
}
