
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
        CustomImageCatch(wallpaper: wallpaper),
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
}


