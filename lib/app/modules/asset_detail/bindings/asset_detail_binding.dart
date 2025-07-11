import 'package:get/get.dart';

import '../controllers/asset_detail_controller.dart';

class AssetDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetDetailController>(
      () => AssetDetailController(),
    );
  }
}
