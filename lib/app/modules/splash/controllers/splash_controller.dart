import 'dart:async';

import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashController extends GetxController {
  final box = SecureStorageService();

  @override
  void onInit() {
    middlewareCheck();
    super.onInit();
  }

  void middlewareCheck() {
    print("middlewareCheck is called");
    print("Current route is: ${Get.currentRoute}");
    Timer(const Duration(milliseconds: 1700), () async {
      var token = await box.getData('token');
      if (token == null || token.isEmpty) {
        return Get.offAllNamed(Routes.LOGIN);
      } else {
        return JwtDecoder.isExpired(token)
            ? Get.offAllNamed(Routes.LOGIN)
            : Get.currentRoute == "/splash"
            ? Get.offAllNamed(Routes.HOME)
            : null;
      }
    });
  }
}
