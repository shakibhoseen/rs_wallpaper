import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:rs_wallpaper/bloc/wallpaper/wallpaper_fetch_bloc.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/my_shadow.dart';
import 'package:rs_wallpaper/res/utils/fonts/font.dart';
import 'package:rs_wallpaper/view/page/category_page.dart';
import 'package:rs_wallpaper/view/page/home_page.dart';
import 'package:rs_wallpaper/view/page/profile_page.dart';
import 'package:rs_wallpaper/view/page/random_page.dart';

import '../bloc/bottom_nav/bottom_index_bloc.dart';

const nameList = ['Home', 'Category' , 'Random', 'Profile'];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final pages = [
    BlocProvider(
      create: (context) => WallpaperFetchBloc(),
      child: const HomePage(),
    ),
    const CategoryPage(),
    const RandomPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(

            child: InkWell(
              radius: 10,
              onTap: () {  },
              child: Ink(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    gradient: MyColors.tabGradient,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: MyShadow.boxShadowNeuMorphism()
                ),
                  child: const Icon(BottomNavBarIcon.category)),

            ),
          ),
          title: BlocBuilder<BottomIndexBloc, BottomIndexState>(builder: (BuildContext context, state) { return Text(nameList[state is BottomIndexChangedState ? state.index: 0], style: const TextStyle(color: Colors.white),); },),
          actions: [
            IconButton(onPressed: (){

            }, icon: Icon(Icons.search)),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: MyShadow.boxShadowNeuMorphism(),
            color: MyColors.canvasColor,
          ),
          child: GNav(
            onTabChange: (index) => context
                .read<BottomIndexBloc>()
                .add(BottomChangedIndexEvent(index: index)),
            selectedIndex: 0,
            gap: 4,
            tabBackgroundGradient: MyColors.tabGradient,
            activeColor: Colors.white,
            color: MyColors.activeTextColor,
            tabBorderRadius: 25,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            tabs: const [
              GButton(
                icon: BottomNavBarIcon.home,
                text: "Home",
              ),
              GButton(
                icon: BottomNavBarIcon.category,
                text: "Category",
              ),
              GButton(
                icon: BottomNavBarIcon.random,
                text: "Random",
              ),
              GButton(
                icon: BottomNavBarIcon.profileIcon,
                text: "Profile",
              ),
            ],
          ),
        ),
        body: BlocBuilder<BottomIndexBloc, BottomIndexState>(
          builder: (context, state) {
            int index = state is BottomIndexChangedState ? state.index : 0;
            return pages[index];
          },
        ),
      ),
    );
  }
}
