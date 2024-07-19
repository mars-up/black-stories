import 'package:black_stories/models/stored.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../helpers/database_helper.dart';
import '../routes/app_routes.dart';

class StoredController extends GetxController {
  final userController = TextEditingController();
  final collectionController = TextEditingController();
  final storyController = TextEditingController();

  var storedList = <Stored>[].obs;

  @override
  void onInit() {
    getAllStored();
    super.onInit();
  }

  bool isEmpty() {
    return storedList.isEmpty;
  }

  void addStoredToDatabase() async {
    final user = userController.text;
    final collection = collectionController.text;
    final story = storyController.text;

    Stored stored = Stored(
    user_id: int.parse(user),
    collection_id: int.parse(collection),
    story_id: int.parse(story),
    dateTimeCompleted: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now()));

    await DatabaseHelper.instance.addStored(stored);
    userController.text = "";
    collectionController.text = "" ;
    storyController.text = "";
    getAllStored();
    Get.back();
  }

  void updateNote(int id, String dTCreated) async {
    final user = userController.text;
    final collection = collectionController.text;
    final story = storyController.text;
    Stored stored = Stored(
      id: id,
      user_id: int.parse(user),
      collection_id: int.parse(collection),
      story_id: int.parse(story),
      dateTimeCompleted: DateFormat("dd-MM-yyyy hh:mm a").format(DateTime.now())
    );
    await DatabaseHelper.instance.updateStored(stored);
    userController.text = "";
    collectionController.text = "" ;
    storyController.text = "";
    getAllStored();
    Get.offAllNamed(AppRoute.HOME);
  }

  void deleteStored(int id) async {
    Stored? stored = await DatabaseHelper.instance.getStored(id);
    if (stored != null) {
      await DatabaseHelper.instance.deleteStored(stored);
    }
    getAllStored();
  }

  void deleteAllNotes() async {
    await DatabaseHelper.instance.deleteAllStored();
    getAllStored();
  }

  void getAllStored() async {
    storedList.value = await DatabaseHelper.instance.getStoredList();
    update();
  }

  void shareNote(String title, String content) {
    Share.share("$title \n$content");
  }
}