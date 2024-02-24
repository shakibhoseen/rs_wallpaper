import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class MessageDownloadNotify {
  String message;
  bool type;

  MessageDownloadNotify(this.message, this.type);

}


class FileDownloader {
  final StreamController<int> _progressController = StreamController<int>.broadcast();

  Stream<int> get progressStream => _progressController.stream;

  Future<MessageDownloadNotify> downloadFile(String url, String nameWithExtension) async {
    final dio = Dio();

    try {
      // final response = await dio.get(
      //   url,
      //   options: Options(
      //     responseType: ResponseType.bytes,
      //   ),
      //   onReceiveProgress: (count, total) {
      //     if (total != -1) {
      //       int percentage = (count / total * 100).floor();
      //       _progressController.add(percentage); // Send progress through stream
      //     }
      //   },
      // );

      //final externalDocumentsDirectory = await getLibraryDirectory();
     // print('getLibraryDirectory ${externalDocumentsDirectory.path}');
      //final x = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
     // print('download directory ${x.toString()}');
      //final y = await getExternalStorageDirectory();
      //print('download directory ${y?.path}');

      // Create 'rs_wallpaper' folder if it doesn't exist
      //final folderPath = '${externalDocumentsDirectory?[0].path}/rs_wallpaper';
      // Directory(folderPath).createSync(recursive: true);
      //
      // final filePath = '$folderPath/$nameWithExtension';
      //
      // //final filePath = '$folderPath/$nameWithExtension';
      //
      //  await File(filePath).writeAsBytes(response.data as Uint8List);


      _progressController.close(); // Close the stream after download is complete

      return MessageDownloadNotify('filePath', true);
    } catch (e) {
      _progressController.close(); // Close the stream in case of an error
      return MessageDownloadNotify('Error downloading video: $e', false);
    }
  }
}

Future<void> downloadWallpaperWithSAF() async {
  final pickedFile = await FilePicker.platform.pickFiles(type: FileType.any);
  if (pickedFile != null) {
    final url = 'https://example.com/wallpaper.jpg'; // Replace with your actual URL
    final dio = Dio();
    final savePath = join(pickedFile.files.single.path!, basename(url));
    print('Wallpaper downloaded to: $savePath');
    try {
      await dio.download(url, savePath);
      // Inform user about successful download and location
      print('Wallpaper downloaded to: $savePath');
    } on DioError catch (e) {
      // Handle download errors gracefully
      print('Error downloading wallpaper: $e');
    }
  } else {
    // User cancelled file selection
    print('Download cancelled');
  }
}

class DownloadManager {
  static const MethodChannel _channel = MethodChannel('download_manager');

  static Future<void> startDownload(String url, String fileName) async {
    try {
      await _channel.invokeMethod('startDownload', {
        'url': url,
        'fileName': fileName,
      });
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }
}


