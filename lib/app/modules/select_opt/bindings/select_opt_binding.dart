import 'package:get/get.dart';

import '../controllers/select_opt_controller.dart';

class SelectOptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectOptController>(
      () => SelectOptController(),
    );
  }
}
