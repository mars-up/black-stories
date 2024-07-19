import 'dart:io';

import 'package:black_stories/controller/collection_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../models/collection.dart';
import '../routes/app_routes.dart';

class CollectionMenu extends StatelessWidget {
  final controller = Get.put(CollectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select collection",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColor.darkBloodColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // showSearch(context: context, delegate: Search());
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GetBuilder<CollectionController>(
        builder: (_) => controller.isEmpty() ? emptyCollections() : viewCollections(),
      ),
    );
  }

  Widget viewCollections() {
    return Scrollbar(
      child: Container(
        color: AppColor.darkGreyColor,
        padding: const EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          shrinkWrap: false,
          itemCount: controller.collections.length,
          itemBuilder: (context, index) {
            Collection collection = controller.collections[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.CARD, arguments: {'collection': controller.collections[index]});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(

                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Titre
                            collection.active == true ?
                            Text(
                              'Black Stories ${collection.id!}',
                              style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.whiteColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ) :
                            Text(
                              'Black Stories ${collection.id!}',
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // collection
                            collection.active == true ? Text(
                              collection.name!,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.red),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ) :
                            Text(
                              collection.name!,
                              style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  fontSize: 18,
                                  color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // img
                            /*
                            Text(
                              controller.collections[index].img!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColor.grayColor),
                            ),
                            */

                  //Image(image: FileImage(File(controller.collections[index].img!)))
                          ],
                        ),
                      ),

                      Container(
                        child :Image.asset(

                            height: 75,
                            fit:BoxFit.fill,
                            "assets/icons/ico256.png"),
                      )

                    ],
                  ),

                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget emptyCollections() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No Collection!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
