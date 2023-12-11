import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../bloc/bottom_nav/bottom_index_bloc.dart';
import '../../../view/view.dart';
import 'routes_name.dart';

class Routes {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (context) =>  BlocProvider(
                  create: (context) => BottomIndexBloc(),
                  child:  HomeScreen(),
                ));
      case RoutesName.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case RoutesName.introScreen:
        return MaterialPageRoute(
          builder: (context) => const IntroScreen(),
        );
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No page route define"),
            ),
          );
        });
    }
  }
}
