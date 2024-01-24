import 'package:flutter/material.dart';
import 'package:rs_wallpaper/service/service_set_wallpaper.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Center(
        child: Text('Category', style: TextStyle(color: Colors.white)),
      ),
        ElevatedButton(
            onPressed: () async{
             // ServiceSetWallPaper wallpaper = ServiceSetWallPaper();
               //await wallpaper.setWallpaper('https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80');
            }
            , child: Text('set wallpaper')),
      ],
    );
  }
}