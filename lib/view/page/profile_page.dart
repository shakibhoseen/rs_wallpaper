import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';
import 'package:rs_wallpaper/res/data/hive/hive_repository.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/route/routes_name.dart';

import '../../res/component/image_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final listString = ['Recent Views','Downloaded', 'Liked'];
  final indexValue = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: ValueListenableBuilder(
            valueListenable: indexValue,
            builder: (context, value, _) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listString.length,
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    indexValue.value = index;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listString[index], style: value==index ? const TextStyle(fontWeight: FontWeight.w600, color: MyColors.activeTextColor) : const TextStyle(color: MyColors.inactiveTextColor),),
                  ),
                );
              },);
            }
          ),
        ),
        const Divider( color: MyColors.inactiveTextColor,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CustomScrollView(

              slivers: [
                FutureBuilder<List<FavoriteItem>>(
                  future: HiveRepository().getAllFavorite(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                              child: CircularProgressIndicator(),
                      ));
                    }
                    if (snapshot.hasError) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                          child: Center(child: Text('Something error. try again')));
                    }
                    final list = snapshot.data;
                    if (list == null || list.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                          child: Center(child: Text('No Items added yet.', style: TextStyle(color: Colors.white),)));
                    }

                    return SliverGrid.builder(
                      itemCount: list.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final item = list[index];
                        final wallpaperItem = Wallpaper(
                            id: item.id,
                            title: item.title,
                            image: item.image,
                            tags: '',
                            viewCount: 0,
                            download: 0,
                            copyrightReport: 0,
                            userId: 0,
                            categories: [
                              Category(
                                  id: item.categoryId,
                                  name: item.categoryName,
                                  image: null,
                                  displayName: item.categoryName,
                                  parentCategoryId: null)
                            ]);

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RoutesName.displayWallPaperScreen,
                                arguments: wallpaperItem);
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: ImageItem(wallpaper: wallpaperItem),
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
      ],
    );
  }
}
