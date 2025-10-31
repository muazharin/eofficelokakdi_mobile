import 'package:get/get.dart';

import '../controllers/open_pdf_controller.dart';

class OpenPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpenPdfController>(
      () => OpenPdfController(),
    );
  }
}
