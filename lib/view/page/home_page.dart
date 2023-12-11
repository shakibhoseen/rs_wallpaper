import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/wallpaper/wallpaper_fetch_bloc.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
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
                      return Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: imageItem(wallpaper: item),
                      );
                    },
                  );
                },
              ),
            ],
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

Widget imageItem({required Wallpaper wallpaper}) {
  return Stack(
    alignment: Alignment.bottomLeft,
    children: [
      CachedNetworkImage(
        imageUrl: wallpaper.image,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: downloadProgress.progress != null
                ? Text('${(downloadProgress.progress! *100).toStringAsFixed(2)} %')
                : const CircularProgressIndicator()),
        //placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(wallpaper.categories[0].name, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 10),),
            SizedBox(height: 4,),
            Text(wallpaper.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, )),
          ],
        ),
      )
    ],
  );
}

int convertToPercentage(double progress) {
  return (progress * 100).toInt();
}


/*
 if (state is WallpaperFetchInitial) {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        } else if (state is ErrorState) {
          Utils.showToastMessage(state.error);
          print(state.error);
        }
 */