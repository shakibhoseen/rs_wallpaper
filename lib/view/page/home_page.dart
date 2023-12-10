import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rs_wallpaper/res/data/retrofit/api_retrofit.dart';
import 'package:rs_wallpaper/res/data/retrofit/model/all_wallpaper.dart';
import 'package:rs_wallpaper/res/utils/utils.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final api = ApiService(Dio(),
      baseUrl: 'https://wallpaper.rsdesignerhub.com/api/v1/rswp/');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomScrollView(
         slivers: [
           FutureBuilder<AllWallpaper>(
             future: ApiService.execute(() => api.allWallpaper(8)),
             builder: (context, snapshot) {
               print(snapshot.data?.data.length);
               if (snapshot.connectionState != ConnectionState.done) {
                 return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
               } else if (snapshot.hasError) {
                 Utils.showToastMessage(snapshot.error.toString());
                 print(snapshot.error.toString());
               }

               return SliverGrid.builder(
                 itemCount: snapshot.data?.data.length ?? 0,
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   crossAxisSpacing: 8.0,
                   mainAxisSpacing: 8.0,
                   childAspectRatio: 0.65,
                 ),
                 itemBuilder: (context, index) {
                   final item = snapshot.data!.data[index];
                   return Container(
                     clipBehavior: Clip.antiAlias,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                     child: imageItem(url: item.image),
                   );
                 },
               );
             },
           ),
         ],
      ),
    );
  }
}
Widget imageItem({required String url}){
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
           ),
      ),
    ),
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child:downloadProgress.progress!=null ? Text('${(convertToPercentage(downloadProgress.progress!))} %') : const CircularProgressIndicator()),
    //placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

int convertToPercentage(double progress) {
  return (progress * 100).toInt();
}