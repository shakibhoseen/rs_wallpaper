

import 'package:rs_wallpaper/res/data/hive/favorite_repository.dart';
import 'package:rs_wallpaper/res/data/hive/recent_view_repository.dart';

class HiveRepository{
  final FavoriteRepository favorite;
  final RecentViewRepository recentView;

  HiveRepository(): favorite = FavoriteRepository(), recentView = RecentViewRepository();
}