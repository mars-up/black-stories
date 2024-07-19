// ignore_for_file: prefer_const_constructors

import 'package:black_stories/screens/sides/back_side.dart';
import 'package:black_stories/screens/splash_screen.dart';
import 'package:get/route_manager.dart';
import '../screens/card_screen.dart';
import '../screens/collection_menu.dart';
import '../screens/home_page.dart';
import 'app_routes.dart';

var getRoutes = [
  GetPage(name: AppRoute.SPLASH, page: () => SplashScreen()),
  GetPage(name: AppRoute.HOME, page: () => HomePage()),

  GetPage(name: AppRoute.CARD, page: () => CardScreen()),
  GetPage(name: AppRoute.COLLECTION, page: () => CollectionMenu()),



  GetPage(name: AppRoute.FORE_SIDE, page: () => BackSide()),
];
