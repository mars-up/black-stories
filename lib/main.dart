import 'package:black_stories/routes/app_pages.dart';
import 'package:black_stories/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Black Stories Game",
        // initialRoute: AppRoute.CARD,
        initialRoute: AppRoute.SPLASH,
        getPages: getRoutes);
  }
}

