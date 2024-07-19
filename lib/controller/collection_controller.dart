import 'package:black_stories/models/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../helpers/database_helper.dart';
import '../models/note_model.dart';
import '../routes/app_routes.dart';

class CollectionController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var collections = <Collection>[].obs;

  @override
  void onInit() {
    getAllCollections();
    super.onInit();
  }

  bool isEmpty() {
    return collections.isEmpty;
  }

  Future<Collection> getCollection(int id) async {
    Collection collection = collections.firstWhere((c) => c.id == id);
    return collection;
  }

  void getAllCollections() async {
    collections.value = await DatabaseHelper.instance.getCollections();
    update();
  }
}
