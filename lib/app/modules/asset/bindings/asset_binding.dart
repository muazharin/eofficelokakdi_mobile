import 'package:eoffice/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

import '../controllers/asset_controller.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetController>(() => AssetController());
    Get.put(SplashController());
  }
}
