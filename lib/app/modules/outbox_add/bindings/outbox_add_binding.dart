import 'package:get/get.dart';

import '../controllers/outbox_add_controller.dart';

class OutboxAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutboxAddController>(
      () => OutboxAddController(),
    );
  }
}
