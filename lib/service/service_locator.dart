



import 'package:get_it/get_it.dart';
import 'package:rs_wallpaper/res/data/hive/hive_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // services
  //getIt.registerSingleton<AudioHandler>(await initAudioService());


  final hiveDatabase = HiveRepository();
  await hiveDatabase.favorite.initialize(); // Wait for the initialization to complete for all

  getIt.registerLazySingleton<HiveRepository>(() => hiveDatabase);

}