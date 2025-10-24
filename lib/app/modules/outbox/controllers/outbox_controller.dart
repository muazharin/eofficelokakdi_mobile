import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';

class OutboxController extends GetxController {
  void handleBackBtn() {
    Get.back();
  }

  void handleAddBtn() {
    Get.toNamed(Routes.OUTBOX_ADD);
  }
}
