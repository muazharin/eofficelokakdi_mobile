import 'package:get/get.dart';

import '../controllers/borrow_add_controller.dart';

class BorrowAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BorrowAddController>(
      () => BorrowAddController(),
    );
  }
}
