import 'package:get/get.dart';

import '../controllers/asset_filter_controller.dart';

class AssetFilterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetFilterController>(
      () => AssetFilterController(),
    );
  }
}
