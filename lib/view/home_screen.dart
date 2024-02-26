import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rs_wallpaper/bloc/all_categories/all_categories_fetch_bloc.dart';

import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/component/both_home_lock_radio.dart';
import 'package:rs_wallpaper/res/component/custom_popup.dart';
import 'package:rs_wallpaper/res/component/radio_list_component.dart';
import 'package:rs_wallpaper/res/component/rounded_button.dart';
import 'package:rs_wallpaper/res/data/shared_pref/setting_datta.dart';
import 'package:rs_wallpaper/res/my_shadow.dart';
import 'package:rs_wallpaper/res/utils/fonts/font.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';

import 'package:rs_wallpaper/view/page/category_page.dart';
import 'package:rs_wallpaper/view/page/home_page.dart';
import 'package:rs_wallpaper/view/page/profile_page.dart';
import 'package:rs_wallpaper/view/page/random_page.dart';

import '../bloc/bottom_nav/bottom_index_bloc.dart';
import '../bloc/wallpaper/common_event_state.dart';
import '../res/utils/operation_format.dart';
import '../service/background_task.dart';

const nameList = ['Home', 'Category', 'Random', 'Profile'];
const _24Hour = '24 Hour';

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
  final backgroundTask = BackgroundTask();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final switchListener = ValueNotifier<(bool, String, String)>((false, _24Hour, 'Home Screen'));
  final settingData = SettingData();

  void getSwitchValue() async {
    final value = await settingData.getSwitchValue();
    timeShortType = value.$2;
    final durationTitle = OperationFormat.getValueGenerate(value.$2);
    final screenStr = OperationFormat.getFullScreenNameFromString(screenType: value.$3);
    final homeLock = OperationFormat.getBooleanFromScreenFormat(screenType: value.$3);
    home = homeLock.$1;
    lock = homeLock.$2;
    switchListener.value = (value.$1, durationTitle.$2, screenStr);
  }

  bool home = true, lock = false;
  String timeShortType ='24h';

  void setSwitchValue(bool activate, ) async {
    await settingData.setSwitchValue(activate: activate, timeFormat: timeShortType, screenType: home&&lock ?'both': lock?'lock':'home');
    if (activate) {
      backgroundTask.register(duration: OperationFormat.getValueGenerate(timeShortType).$1,);
    } else {
      backgroundTask.unregisterBackgroundTask();
    }
    getSwitchValue();
  }

  void inactiveSwitch()async{
    await settingData.setSwitchOnly(activate: false);
    getSwitchValue();
  }


  @override
  Widget build(BuildContext context) {
    getSwitchValue();
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: drawerItems(),
        appBar: AppBar(
          leading: Center(
            child: InkWell(
              radius: 10,
              onTap: () {
                _key.currentState?.openDrawer();
              },
              child: Ink(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      gradient: MyColors.tabGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: MyShadow.boxShadowNeuMorphism()),
                  child: const Icon(BottomNavBarIcon.category)),
            ),
          ),
          title: BlocBuilder<BottomIndexBloc, BottomIndexState>(
            builder: (BuildContext context, state) {
              return Text(
                nameList[state is BottomIndexChangedState ? state.index : 0],
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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

  Drawer drawerItems() {
    return Drawer(
      backgroundColor: MyColors.drawerBackColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 18,
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Container(
            //       height: 50,
            //       width: 50,
            //       clipBehavior: Clip.antiAlias,
            //       decoration: const BoxDecoration(
            //           shape: BoxShape.circle
            //       ),
            //       child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRvlGaf4hpR1g9cTTFirG2kl862LqD0Q2j2vff3Np6lgKt0kw9t1_SQgMblJ_a1IH4xQQ&usqp=CAU', fit: BoxFit.cover,),
            //     ),
            //     const SizedBox(width: 12,),
            //     const Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Text('Md. Rakibul Islam', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight:  FontWeight.w600),),
            //         Text('Rakib23', style: TextStyle(color: Colors.white, ),),
            //       ],
            //     )
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            itemDesign(icon: DrawerIcons.wallpaperIcon, title: 'Wallpaper'),

            ValueListenableBuilder(
              builder: (context, value, _) {
                return Row(
                  children: [
                    Icon(DrawerIcons.autoIcon,
                        color: value.$1 ? Colors.lightGreen : Colors.white),
                    const SizedBox(
                      width: 14,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Auto Change',
                          style: TextStyle(
                              color: value.$1 ? Colors.lightGreen : Colors.white),
                        ),
                        Text(
                          '${value.$2} (${value.$3})',
                          style: TextStyle(
                              color: value.$1
                                  ? Colors.lightGreen
                                  : MyColors.activeTextColor,
                              fontSize: 10),
                        )
                      ],
                    ),
                    Switch(
                        value: value.$1,
                        onChanged: (value) {
                          if(!value){
                            inactiveSwitch();
                            return;
                          }
                          CustomPopup.getPopUp(
                            context,
                            (p0) => popUpDesign(
                              () {
                                setSwitchValue(value);
                                   Navigator.pop(p0);
                              },
                            ),
                          );
                          //setSwitchValue(value);
                        }),
                  ],
                );
              },
              valueListenable: switchListener,
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

  Widget popUpDesign(VoidCallback onPressed) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Adjust Auto-Change Schedule',
              style: TextStyle(fontSize: 18, color: MyColors.activeTextColor),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListComponent(
              feedBackList: (timeSortFormat) {
                timeShortType = timeSortFormat;
              },
              timeFormat: timeShortType,
            ),
            BothHomeLockDesign(feedBack: (home, lock) {
              this.home = home;
              this.lock = lock;
            }, home: home, lock: lock,),
            SizedBox(
              height: 8,
            ),
            RoundedButton(
                title: 'Set',
                onPress: onPressed)
          ],
        ),
      ),
    );
  }
}

Widget itemDesign({required IconData icon, required String title}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(
          width: 14,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}
