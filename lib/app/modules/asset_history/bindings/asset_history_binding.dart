import 'package:get/get.dart';

import '../controllers/asset_history_controller.dart';

class AssetHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetHistoryController>(
      () => AssetHistoryController(),
    );
  }
}
