import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/wallpaper/wallpaper_fetch_bloc.dart';
import 'package:rs_wallpaper/res/component/image_item.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  late WallpaperFetchBloc fetchBloc;

  @override
  void initState() {
    fetchBloc = context.read<WallpaperFetchBloc>();
    _scrollController = ScrollController();
    fetchBloc.add(WallpaperFetchPageEvent());
    _scrollController.addListener(_onScroll);
    super.initState();
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
    List<Wallpaper> wallpapers = [];
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric( horizontal: 8),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                BlocBuilder<WallpaperFetchBloc, WallpaperFetchState>(
                  builder: (context, state) {
                     if(state is SuccessfulState){
                        wallpapers.addAll(state.wallpaper.data);
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
                          onTap: (){
                            Navigator.of(context).pushNamed(RoutesName.displayWallPaperScreen, arguments: item);
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
                : Container();
          },
        )
      ],
    );
  }
}


