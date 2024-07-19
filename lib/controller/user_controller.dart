import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

import '../constants/enums.dart';
import '../helpers/database_helper.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';

class UserController extends GetxController {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final rightsController = TextEditingController();

  var users = <User>[].obs;

  @override
  void onInit() {
    getAllUsers();
    super.onInit();
  }

  bool isEmpty() {
    return users.isEmpty;
  }

  void addUserToDatabase() async {
    String id = idController.text;
    String username = nameController.text;
    String password = passwordController.text;
    String rights = rightsController.text;

    User user = User(
        id: int.parse(id),
        username: username,
        password: password,
        rights : rights
    );

    await DatabaseHelper.instance.addUser(user);
    idController.text = "";
    nameController.text = "";
    passwordController.text = "";
    rightsController.text = "";
    getAllUsers();
    Get.back();
  }

  void updateUser(int id, String dTCreated) async {
    String id = idController.text;
    String username = nameController.text;
    String password = passwordController.text;
    String rights = rightsController.text;
    User user = User(
        id: int.parse(id),
        username: username,
        password: password,
        rights : rights
    );
    await DatabaseHelper.instance.updateUser(user);
    idController.text = "";
    nameController.text = "";
    passwordController.text = "";
    rightsController.text = "";
    getAllUsers();
    Get.offAllNamed(AppRoute.HOME);
  }

  void deleteStored(int id) async {
    User? user = await DatabaseHelper.instance.getUser(id);
    if (user != null) {
      await DatabaseHelper.instance.deleteUser(user);
    }
    getAllUsers();
  }

  void updateUserRigths(int id, UserRigth rigth) async {
    User user = users.firstWhere((user) => user.id == id);
    user.rights = rigth.name;
    await DatabaseHelper.instance.updateUser(user);
    getAllUsers();
  }

  void getAllUsers() async {
    users.value = await DatabaseHelper.instance.getUserList();
    update();
  }

}
