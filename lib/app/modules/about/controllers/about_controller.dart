import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutController extends GetxController {
  var packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void onInit() {
    _initPackageInfo();
    super.onInit();
  }

  void handleBackBtn() {
    Get.back();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    update();
  }
}
