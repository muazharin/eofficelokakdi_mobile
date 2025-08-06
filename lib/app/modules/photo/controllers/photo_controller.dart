import 'package:get/get.dart';

class PhotoController extends GetxController {
  var arg = Get.arguments;
  var listImg = <String>[];

  @override
  void onInit() {
    listImg = arg['images'];
    super.onInit();
  }

  void handleBackBtn() {
    Get.back();
  }
}
