import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rs_wallpaper/res/colors.dart';
import 'package:rs_wallpaper/res/component/back_button_widget.dart';
import 'package:rs_wallpaper/res/component/image_cache.dart';
import 'package:rs_wallpaper/res/component/loading_progress_dialog.dart';
import 'package:rs_wallpaper/res/data/hive/favorite_item.dart';
import 'package:rs_wallpaper/res/data/hive/hive_repository.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/asset/asset_name.dart';
import 'package:rs_wallpaper/res/utils/fonts/font.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';
import 'package:rs_wallpaper/service/flutter_downloader.dart';
import 'package:rs_wallpaper/service/interestitial_add_helper.dart';
import 'package:rs_wallpaper/service/service_set_wallpaper.dart';

import '../../service/service_locator.dart';

class DisplayWallpaperScreen extends StatefulWidget {
  final Wallpaper wallpaper;

  const DisplayWallpaperScreen({super.key, required this.wallpaper});

  @override
  State<DisplayWallpaperScreen> createState() => _DisplayWallpaperScreenState();
}

class _DisplayWallpaperScreenState extends State<DisplayWallpaperScreen> {
  final heartValue = ValueNotifier<bool>(false);
  final downloadValue = ValueNotifier<bool>(false);
  late InterstitialAdHelper interstitialAdHelper;

  final repo = getIt<HiveRepository>();
  final fileDownloader = FileDownloader();

  void getFavoriteDetails() async {
    final has =
        await repo.favorite.hasParticularItem(int.parse(widget.wallpaper.id));
    heartValue.value = has;
    final recentHas =
        await repo.recentView.hasParticularItem(int.parse(widget.wallpaper.id));
    if (recentHas) {
      await repo.recentView.deleteFavoriteItem(int.parse(widget.wallpaper.id));
    }

    await repo.recentView.addRecentItem(convertFavoriteItem(widget.wallpaper));
    interstitialAdHelper = getIt<InterstitialAdHelper>();
  }

  void saveDownloadDetails() async {
    bool has = await check();
    if (has) return;
    await repo.download.addDownloadItem(convertFavoriteItem(widget.wallpaper));
  }

  Future<bool> check() async {
    final has =
        await repo.download.hasParticularItem(int.parse(widget.wallpaper.id));
    downloadValue.value = has;

    return has;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getFavoriteDetails();
    check();
    log("image ${widget.wallpaper.fullImage}");
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result ) {
          if(didPop)return;
          final loaded = interstitialAdHelper.isAdLoaded();
          if(interstitialAdHelper.loading ){
            Utils.showToastMessage('Advertisement loading please wait...');
            return;
          }

          if(interstitialAdHelper.getLoadedAdd){
            // interstitialAdHelper.showInterstitialAd((){
            //   log('................................dismis call inside  show from display');
            //   Navigator.pop(context);
            // });
            return;
          }
          Navigator.pop(context);

          log('........................................back press');

        },
        child: Stack(
          children: [
            CustomImageCatch(url: widget.wallpaper.fullImage),
            SafeArea(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      BackButtonWidget(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(DisplayImageIcons.backArrow,
                              size: 15, color: Colors.white),
                        ),
                        onPress: () {
                          Navigator.maybePop(context);
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.wallpaper.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              Text(
                                  widget.wallpaper.categories?.displayName != null
                                      ? "${widget.wallpaper.categories?.displayName}"
                                      : 'category',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      ValueListenableBuilder(
                          valueListenable: heartValue,
                          builder: (context, value, _) {
                            return IconButton(
                                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0x16151E40))),
                                onPressed: () async {
                                  heartValue.value = !value;

                                  if (!value) {
                                    // add favorite
                                    await repo.favorite.addFavoriteItem(
                                        convertFavoriteItem(widget.wallpaper));
                                    Utils.showToastMessage('add');
                                  } else {
                                    //remove
                                    await repo.favorite.deleteFavoriteItem(
                                        int.parse(widget.wallpaper.id));
                                    Utils.showToastMessage('remove');
                                  }
                                },
                                icon: value
                                    ? const Icon(
                                        DisplayImageIcons.love,
                                        color: Colors.pink,
                                      )
                                    : const Icon(
                                        DisplayImageIcons.loveUnFill,
                                        color: MyColors.activeTextColor,
                                      ));
                          }),
                    ],
                  ),
                ),
                ContainerWithBlur(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.report_gmailerrorred,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          DisplayImageIcons.sharing,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          log(widget.wallpaper.image);
                        },
                      ),

                      // StreamBuilder<int>(
                      //   stream: fileDownloader.progressStream,
                      //   builder: (context, snapshot) {
                      //     print(".........data ...${snapshot.data}");
                      //     if(snapshot.hasData) {
                      //       return Text('${snapshot.data}');
                      //     }
                      //     return IconButton(icon: const Icon(DisplayImageIcons.download, color: Colors.white,), onPressed: () async{
                      //       final p = await fileDownloader.downloadFile(widget.wallpaper.image, 'name.jpg');
                      //       Utils.showToastMessage('${p.message}');
                      //       print(p.message);
                      //     },);
                      //   }
                      // ),
                      ValueListenableBuilder<bool>(
                          valueListenable: downloadValue,
                          builder: (context, value, _) {
                            return Stack(
                              alignment: Alignment.topRight,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    DisplayImageIcons.download,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if( !interstitialAdHelper.getLoadedAdd && !interstitialAdHelper.loading){
                                      interstitialAdHelper.loadInterstitialAd();
                                    }
                                    String extention = getFileExtensionFromUrl(
                                        widget.wallpaper.fullImage);
                                    DownloadManager.startDownload(
                                        widget.wallpaper.fullImage,
                                        '${widget.wallpaper.title}.$extention');
                                    saveDownloadDetails();
                                  },
                                ),
                                Visibility(
                                  visible: value,
                                  child: Positioned(
                                      child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: const BoxDecoration(
                                        color: Colors.lightGreen,
                                        shape: BoxShape.circle),
                                  )),
                                )
                              ],
                            );
                          }),
                      IconButton(
                        icon: const Icon(
                          DisplayImageIcons.home,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setWallpaper(widget.wallpaper.fullImage,
                              ScreenType.homeScreen, context);
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          DisplayImageIcons.lock,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setWallpaper(widget.wallpaper.fullImage,
                              ScreenType.lockScreen, context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

void setWallpaper(String url, ScreenType screenType, BuildContext context) async{
  ServiceSetWallPaper wallpaper = ServiceSetWallPaper();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
          backgroundColor: Colors.green.withOpacity(0.14),
          clipBehavior: Clip.antiAlias,
          content: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 25, sigmaY: 25, tileMode: TileMode.mirror),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetName.loadingGif,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Processing...',
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ));
    },
  );



  // wallpaper.setWallpaper(url, screenType).then((value) {
  //   final message = screenType == ScreenType.homeScreen
  //       ? 'Successfully Changed the home screen Wallpaper'
  //       : 'Successfully Changed the Lock screen Wallpaper';
  //   Navigator.pop(context);
  //   if (value) {
  //     Utils.showFlashBarMessage(message, FlashType.success, context);
  //   } else {
  //     Utils.showFlashBarMessage(
  //         'Opps! something went wrong', FlashType.error, context);
  //   }
  // });
  ///new

  // Create an isolate and set up communication
  final receivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    isolateFunction,
    receivePort.sendPort,
  );

  final sendPort = await receivePort.first as SendPort;
  final responsePort = ReceivePort();



  sendPort.send({
    'token': RootIsolateToken.instance!,
    'url': url,
    'screenType': screenType,
    'sendResponse': responsePort.sendPort,
  });

  // Wait for the result from the isolate
  responsePort.listen((message) {
    Navigator.of(context).pop(); // Close the dialog

    final result = message as Map<String, dynamic>;
    final success = result['success'] as bool;
    final error = result['error'] as String?;

    final messageText = success
        ? (screenType == ScreenType.homeScreen
        ? 'Successfully Changed the home screen Wallpaper'
        : 'Successfully Changed the Lock screen Wallpaper')
        : 'Oops! ${error ?? 'something went wrong'}';

    Utils.showFlashBarMessage(messageText, success ? FlashType.success : FlashType.error, context);
    final helper = getIt<InterstitialAdHelper>();
    if( !helper.getLoadedAdd && !helper.loading){
      helper.loadInterstitialAd().showWithDialog(context, message: 'getting advertise').then((value) {
        if(helper.getLoadedAdd){
          helper.showInterstitialAd((){
            log('................................dismis call inside  show from display');
            Navigator.pop(context);
          });
        }
      },);
    }

    // Cleanup the isolate
    isolate.kill(priority: Isolate.immediate);
  });
}

Future<void> isolateFunction(SendPort sendPort) async {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  await for (final message in receivePort) {
    final data = message as Map<String, dynamic>;
    final url = data['url'] as String;
    final screenType = data['screenType'] as ScreenType;
    final sendResponse = data['sendResponse'] as SendPort;
    final token = data['token'] as RootIsolateToken;

    // Initialize the binary messenger
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);

    try {
      // Simulate a heavy task (e.g., setting wallpaper)
      final wallpaper = ServiceSetWallPaper();
      final result = await wallpaper.setWallpaper(url, screenType);
      sendResponse.send({'success': result});
    } catch (error) {
      sendResponse.send({'success': false, 'error': error.toString()});
    }
  }
}

class ContainerWithBlur extends StatelessWidget {
  final Widget child;

  const ContainerWithBlur({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      //margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        color: //const Color(0x16151E40)
        Colors.white
            .withOpacity(0.1), // Set the background color with opacity
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 35.0, sigmaY: 35.0), child: child),
    );
  }
}
