import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';

class CustomImageCatch extends StatelessWidget {
  final Wallpaper wallpaper;
  const CustomImageCatch({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
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
    );
  }
}
