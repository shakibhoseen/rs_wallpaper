import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/wallpaper/common_event_state.dart';

import '../../res/component/image_item.dart';
import '../../res/constant.dart';
import '../../res/data/retrofit/model/all_wallpaper.dart';
import '../../res/utils/route/routes_name.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  late ScrollController _scrollController;

  late RandomWallpaperFetchBloc fetchBloc;
  List<Wallpaper> wallpapers = [];
 

  @override
  void initState() {
    super.initState();
    fetchBloc = context.read<RandomWallpaperFetchBloc>();
    _scrollController = ScrollController();
    if (fetchBloc.wallpaperIndex.containsKey(Constant.randomKey)) {
      fetchBloc.add(WallpaperLoadOldDataEvent(categoryId: 0));// random its not use
    } else {
      fetchBloc.add(WallpaperFetchPageEvent());
    }
    _scrollController.addListener(_onScroll);
  

  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // if (hasPageEnd[0]) {
      //   Utils.showToastMessage('you reached the end of pages');
      //   return;
      // }
      //BlocProvider.of<WallpaperFetchBloc>(context)
      fetchBloc.add(WallpaperFetchPageEvent());
    }
  }




  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
       
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                BlocBuilder<RandomWallpaperFetchBloc, WallpaperFetchState>(
                  builder: (context, state) {
                    if (state is SuccessfulState) {
                      log('${state.wallpaper.data.length}');
                      wallpapers.addAll(state.wallpaper.data);
                    } else if (state is ErrorState) {
                      return SliverToBoxAdapter(
                          child: Text(
                        state.error,
                        style: const TextStyle(color: Colors.white),
                      ));
                    } else if (state is LoadOldDataState) {
                      wallpapers.clear();
                      wallpapers.addAll(state.data);
                    }
                    return SliverGrid.builder(
                      itemCount: wallpapers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final item = wallpapers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RoutesName.displayWallPaperScreen,
                                arguments: item);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: ImageItem(wallpaper: item),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<RandomWallpaperFetchBloc, WallpaperFetchState>(
          builder: (context, state) {
            return state is LoadingState
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : const SizedBox.shrink();
          },
        )
      ],
    );
  }
}