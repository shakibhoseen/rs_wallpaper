
import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';

import 'image_cache.dart';

class ImageItem extends StatelessWidget {
  final Wallpaper wallpaper;
  const ImageItem({super.key, required this.wallpaper});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.bottomLeft,
      children: [
        CustomImageCatch(url: wallpaper.image),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(wallpaper.categories?.name ?? 'Not found', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 10),),
              const SizedBox(height: 4,),
              Text(wallpaper.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, )),
            ],
          ),
        )
      ],
    );
  }
}


