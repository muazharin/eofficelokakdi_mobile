import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var nip = TextEditingController();
  var password = TextEditingController();

  void handleLogin() {
    Get.offAllNamed(Routes.HOME);
  }
}
