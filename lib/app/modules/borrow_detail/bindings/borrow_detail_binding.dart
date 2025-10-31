import 'package:get/get.dart';

import '../controllers/borrow_detail_controller.dart';

class BorrowDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BorrowDetailController>(
      () => BorrowDetailController(),
    );
  }
}
