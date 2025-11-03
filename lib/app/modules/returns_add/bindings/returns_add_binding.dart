import 'package:get/get.dart';

import '../controllers/returns_add_controller.dart';

class ReturnsAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnsAddController>(
      () => ReturnsAddController(),
    );
  }
}
