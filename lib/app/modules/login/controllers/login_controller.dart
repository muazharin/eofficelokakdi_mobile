import 'dart:convert';

import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var box = SecureStorageService();
  var nip = TextEditingController();
  var password = TextEditingController();
  var isLoading = false;
  var keyForm = GlobalKey<FormState>();

  void handleLogin() async {
    if (keyForm.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        final response = await Api().postWithoutToken(
          path: AppVariable.signin,
          data: {
            "user_nip": int.parse(nip.text),
            "user_password": password.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          box.saveData("token", result['token']);
          Get.offNamed(Routes.HOME);
        } else {
          snackbarDanger(message: "Terjadi Kesalahans");
        }
      } catch (e) {
        snackbarDanger(message: e.toString());
      } finally {
        isLoading = false;
        update();
      }
    }
  }
}
