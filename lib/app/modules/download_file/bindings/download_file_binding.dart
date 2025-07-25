import 'package:get/get.dart';

import '../controllers/download_file_controller.dart';

class DownloadFileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadFileController>(
      () => DownloadFileController(),
    );
  }
}
