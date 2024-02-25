import 'package:rs_wallpaper/res/data/hive/favorite_repository.dart';
import 'package:rs_wallpaper/res/data/hive/recent_view_repository.dart';

import 'download_repository.dart';

class HiveRepository {
  final FavoriteRepository favorite;
  final RecentViewRepository recentView;
  final DownloadRepository download;

  HiveRepository()
      : favorite = FavoriteRepository(),
        recentView = RecentViewRepository(),
        download = DownloadRepository();
}
