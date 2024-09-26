import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'bloc/all_categories/all_categories_fetch_bloc.dart';
import 'bloc/wallpaper/common_event_state.dart';



class MyApp extends StatelessWidget {

  const MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WallpaperFetchBloc(),
        ),
        BlocProvider(
          create: (context) => AllCategoriesFetchBloc(),
        ),
        BlocProvider(
          create: (context) => RandomWallpaperFetchBloc(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}