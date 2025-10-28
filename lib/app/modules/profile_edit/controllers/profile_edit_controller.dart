import 'dart:convert';

import 'package:eoffice/app/data/models/user.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfileEditController extends GetxController {
  var arg = Get.arguments;
  var data = UserModel();
  var isLoading = false;
  var keyForm = GlobalKey<FormState>();
  var nip = TextEditingController();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var birth = TextEditingController();
  var birthFormat = DateTime.now();
  var address = TextEditingController();

  @override
  void onInit() {
    data = arg["data"] as UserModel;
    setData();
    super.onInit();
  }

  void setData() {
    nip.text = data.userNip.toString();
    name.text = data.userName!;
    email.text = data.userEmail!;
    phone.text = data.userPhone!;
    birth.text = DateFormat("dd MMM yyyy", "id").format(data.userTglLahir!);
    birthFormat = data.userTglLahir!;
    address.text = data.userAddress!;
    update();
  }

  void handleSelectDate(DateTime date) {
    birth.text = DateFormat("dd MMM yyyy", "id").format(date);
    birthFormat = date;
    update();
  }

  void handleSubmit() async {
    if (keyForm.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        final response = await Api().putWithToken(
          path: AppVariable.user,
          queryParameters: {"user_id": data.userId},
          data: {
            "user_email": email.text,
            "user_name": name.text,
            "user_phone": phone.text,
            "user_address": address.text,
            "user_date": DateFormat("yyyy-MM-dd").format(birthFormat),
          },
        );

        var result = jsonDecode(response.toString());
        if (result['status']) {
          isLoading = false;
          snackbarSuccess(message: "Data berhasil diperbaharui");
          Get.until((route) => Get.currentRoute == Routes.PROFILE);
        } else {
          isLoading = false;
          snackbarDanger(message: result["message"]);
        }
      } catch (e) {
        isLoading = false;
        snackbarDanger(message: e.toString());
      } finally {
        update();
      }
    }
  }
}
