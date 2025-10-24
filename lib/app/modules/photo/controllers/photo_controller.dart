import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  var arg = Get.arguments;
  var listImg = <String>[];
  var imgType = "network";
  var pageController = PageController();

  @override
  void onInit() {
    listImg = arg['images'];
    imgType = arg['img_type'] ?? "network";
    pageController = PageController(initialPage: arg['index'] ?? 0);
    update();
    super.onInit();
  }

  void handleBackBtn() {
    Get.back();
  }
}
