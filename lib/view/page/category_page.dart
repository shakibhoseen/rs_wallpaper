import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_wallpaper/bloc/all_categories/all_categories_fetch_bloc.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_categories.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/asset/asset_name.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';
import 'package:rs_wallpaper/service/service_set_wallpaper.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AllCategoriesFetchBloc>().add(AllCategoriesFetchEventInit());
    return Column(children: [
      Expanded(
          child: BlocBuilder<AllCategoriesFetchBloc, AllCategoriesFetchState>(
        builder: (context, state) {
          if (state is LoadingState || state is AllCategoriesFetchInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          if (state is SuccessfulState) {
            final data = state.allCategories.data;
            final str = data[0].image ?? '';
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.showWallPaperByCategoryScreen, arguments: item.id);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: AspectRatio(
                      aspectRatio: 2.57,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: item.image == null
                                  ? Image.asset(
                                      AssetName.categoryDemoPng,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      item.image!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.asset(
                                          AssetName.categoryDemoPng,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    ]);
  }
}
