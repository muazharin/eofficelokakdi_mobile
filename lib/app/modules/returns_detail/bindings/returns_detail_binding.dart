import 'package:get/get.dart';

import '../controllers/returns_detail_controller.dart';

class ReturnsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnsDetailController>(
      () => ReturnsDetailController(),
    );
  }
}
