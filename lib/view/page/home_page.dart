import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/all_categories/all_categories_fetch_bloc.dart'
    as category;
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/component/image_item.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';
import 'package:rs_wallpaper/view/design/home_page_design.dart';

import '../../bloc/all_categories/all_categories_fetch_bloc.dart';
import '../../bloc/wallpaper/common_event_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  late WallpaperFetchBloc fetchBloc;
  List<Wallpaper> wallpapers = [];
  int selectedCategory = -1; // represent a all

  @override
  void initState() {
    super.initState();
    fetchBloc = context.read<WallpaperFetchBloc>();
    _scrollController = ScrollController();
    if (fetchBloc.wallpaperIndex.containsKey('-1')) {
      fetchBloc.add(WallpaperLoadOldDataEvent(categoryId: selectedCategory));
    } else {
      fetchBloc.add(WallpaperByCategoryEvent(categoryId: selectedCategory));
    }
    _scrollController.addListener(_onScroll);
    final handel = context.read<AllCategoriesFetchBloc>();
    handel.categories.isEmpty ? handel.add(AllCategoriesFetchEventInit()) :
     handel.add(LoadOldCategoriesEvent());

  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // if (hasPageEnd[0]) {
      //   Utils.showToastMessage('you reached the end of pages');
      //   return;
      // }
      //BlocProvider.of<WallpaperFetchBloc>(context)
      fetchBloc.add(WallpaperByCategoryEvent(categoryId: selectedCategory));
    }
  }

  void getCategoryIdWallpaper(int categoryId){
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    selectedCategory = categoryId;
    if (fetchBloc.wallpaperIndex.containsKey('$categoryId')) {
      fetchBloc.add(WallpaperLoadOldDataEvent(categoryId: categoryId));
    } else {
      fetchBloc.add(WallpaperByCategoryEvent(categoryId: categoryId));
    }
  }

  Widget showList(List<Category> data, String msg) {
    return HomePageDesign.listSelectUi(listString: [
      ('All', '-1'),
      ...data.map((e) => ('${e.displayName}', e.id)).toList()
    ], onTap: (id) {
      wallpapers.clear();
      getCategoryIdWallpaper(int.parse(id));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        BlocBuilder<category.AllCategoriesFetchBloc,
            category.AllCategoriesFetchState>(
          builder: (context, state) {
           return state.join(
                    (initial) => const Text('init', style: TextStyle(color: Colors.white),),
                    (loading) => const Text('Loading..', style: TextStyle(color: Colors.white),),
                    (success) => showList(success.allCategories.data, 'success'),
                (error) => Text('Opp\'s! ${error.error}', style: const TextStyle(color: Colors.white),),
                    (oldData) => showList(oldData.categories, 'oldData'),);
          },
        ),
        const Divider(
          color: MyColors.inactiveTextColor,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                BlocBuilder<WallpaperFetchBloc, WallpaperFetchState>(
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
    );
  }
}
