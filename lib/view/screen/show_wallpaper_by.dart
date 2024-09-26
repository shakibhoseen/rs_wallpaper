import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/wallpaper/common_event_state.dart';
import '../../res/component/image_item.dart';
import '../../res/data/retrofit/model/all_wallpaper.dart';
import '../../res/utils/route/routes_name.dart';

class ShowWallpaperBy extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  Function(BuildContext) apiHit;
  ShowWallpaperBy({super.key, required this.apiHit});

  void _onScroll(BuildContext context) {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // if (hasPageEnd[0]) {
      //   Utils.showToastMessage('you reached the end of pages');
      //   return;
      // }
      //BlocProvider.of<WallpaperFetchBloc>(context)
      apiHit(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    apiHit(context);
    //context.read<WallpaperFetchBloc>().add(WallpaperFetchPageEvent());
    _scrollController.addListener(() {
      _onScroll(context);
    });
    List<Wallpaper> wallpapers = [];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    BlocBuilder<WallpaperFetchBloc, WallpaperFetchState>(
                      builder: (context, state) {
                        log('state is category wallpaper ${state} ${state is ErrorState ? state.error : null}');
                        if (state is SuccessfulState) {
                          wallpapers.addAll(state.wallpaper.data);
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
            BlocBuilder<WallpaperFetchBloc, WallpaperFetchState>(
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
        ),
      ),
    );
  }
}
