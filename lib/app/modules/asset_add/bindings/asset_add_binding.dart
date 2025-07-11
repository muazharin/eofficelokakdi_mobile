import 'package:get/get.dart';

import '../controllers/asset_add_controller.dart';

class AssetAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetAddController>(
      () => AssetAddController(),
    );
  }
}
