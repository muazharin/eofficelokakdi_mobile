import 'package:get/get.dart';

import '../controllers/outbox_controller.dart';

class OutboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutboxController>(
      () => OutboxController(),
    );
  }
}
