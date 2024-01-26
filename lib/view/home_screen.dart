import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rs_wallpaper/bloc/all_categories/all_categories_fetch_bloc.dart';

import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/my_shadow.dart';
import 'package:rs_wallpaper/res/utils/fonts/font.dart';
import 'package:rs_wallpaper/view/page/category_page.dart';
import 'package:rs_wallpaper/view/page/home_page.dart';
import 'package:rs_wallpaper/view/page/profile_page.dart';
import 'package:rs_wallpaper/view/page/random_page.dart';

import '../bloc/bottom_nav/bottom_index_bloc.dart';
import '../bloc/wallpaper/common_event_state.dart';

const nameList = ['Home', 'Category' , 'Random', 'Profile'];

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final pages = [
    BlocProvider(
      create: (context) => WallpaperFetchBloc(),
      child: const HomePage(),
    ),
    BlocProvider(
      create: (context) => AllCategoriesFetchBloc(),
      child: const CategoryPage(),
    ),
    
    const RandomPage(),
    const ProfilePage(),
  ];

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: drawerItems(),
        appBar: AppBar(
          leading: Center(

            child: InkWell(
              radius: 10,
              onTap: () {   _key.currentState?.openDrawer();},
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

            }, icon: const Icon(Icons.search)),
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
Drawer drawerItems(){

  return Drawer(
    backgroundColor: MyColors.drawerBackColor,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 18,),
          Row(
            children: [
              Container(
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle
                ),
                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRvlGaf4hpR1g9cTTFirG2kl862LqD0Q2j2vff3Np6lgKt0kw9t1_SQgMblJ_a1IH4xQQ&usqp=CAU', fit: BoxFit.cover,),
              ),
              const SizedBox(width: 12,),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Md. Rakibul Islam', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight:  FontWeight.w600),),
                  Text('Rakib23', style: TextStyle(color: Colors.white, ),),
                ],
              )
            ],
          ),
          SizedBox(height: 20,),
          itemDesign(icon: DrawerIcons.wallpaperIcon, title: 'Wallpaper'),
          Row(
            children: [
              itemDesign(icon: DrawerIcons.autoIcon, title: 'Auto Change'),
              Switch(value: false, onChanged: (value){

              })
            ],
          ),
          itemDesign(icon: DrawerIcons.shareIcon, title: 'Share'),
          itemDesign(icon: DrawerIcons.starIcon, title: 'Rate us'),
          const SizedBox(height: 40),
          itemDesign(icon: DrawerIcons.contactIcon, title: 'Contact us'),
          itemDesign(icon: DrawerIcons.aboutUs, title: 'About us'),
          itemDesign(icon: Icons.copyright, title: 'Copyright'),
          const SizedBox(height: 40),
          itemDesign(icon: DrawerIcons.exitToApp, title: 'Exit'),
        ],
      ),
    ),
  );
}

Widget itemDesign({required IconData icon, required String title}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 14,),
        Text(title, style: const TextStyle(color: Colors.white),)
      ],
    ),
  );
}