import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controller/user_controller.dart';
import '../routes/app_pages.dart';
import '../routes/app_routes.dart';
import '../widget/alert_dialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Black Stories Game",
        // initialRoute: AppRoute.CARD,
        initialRoute: AppRoute.COLLECTION,
        getPages: getRoutes);
  }
}