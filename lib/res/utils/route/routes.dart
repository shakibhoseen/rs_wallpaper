import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/wallpaper/common_event_state.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/view/screen/display_wallpaper_screen.dart';
import 'package:rs_wallpaper/view/screen/show_wallpaper_by.dart';

import '../../../bloc/bottom_nav/bottom_index_bloc.dart';
import '../../../view/view.dart';
import 'routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => BottomIndexBloc(),
                  child: HomeScreen(),
                ));
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case RoutesName.introScreen:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        );
      case RoutesName.displayWallPaperScreen:
        final wallpaper = settings.arguments as Wallpaper;
        return MaterialPageRoute(
          builder: (context) =>  DisplayWallpaperScreen(wallpaper: wallpaper),
        );
        case RoutesName.showWallPaperByCategoryScreen:
          final categoryId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) =>  BlocProvider(
            create: (context1) => WallpaperByCategoryBloc(),
            child:
            ShowWallpaperBy(apiHit: (BuildContext contextp){
              contextp.read<WallpaperByCategoryBloc>().add(WallpaperByCategoryEvent(categoryId: categoryId));
            }),
          ),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No page route define"),
            ),
          );
        });
    }
  }
}
