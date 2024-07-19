import 'package:black_stories/models/collection.dart';
import 'package:black_stories/models/story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../helpers/database_helper.dart';
import '../models/note_model.dart';
import '../routes/app_routes.dart';

class StoryController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var stories = <Story>[].obs;

  @override
  void onInit() {
    getAllStories();
    super.onInit();
  }

  bool isEmpty() {
    return stories.isEmpty;
  }

  Future<Story> getStory(int id) async {
    Story story = stories.firstWhere((c) => c.id == id);
    return story;
  }

  void getStoriesByCollection(String collection) async {
    stories.value = await DatabaseHelper.instance.getStories();

    update();
  }

  void getAllStories() async {
    stories.value = await DatabaseHelper.instance.getStories();
    update();
  }
}
