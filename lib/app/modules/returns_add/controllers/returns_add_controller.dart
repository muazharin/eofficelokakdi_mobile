import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReturnsAddController extends GetxController {
  var title = "Ajukan";
  var key = GlobalKey<FormState>();
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var loanSelect = TextEditingController();
  var loanSelectModel = SelectOptModel();

  @override
  void onInit() async {
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
    super.onInit();
  }

  void handleSelectOpt(dynamic arg) {
    Get.toNamed(Routes.SELECT_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        if (arg["title"] == "Pilih Peminjaman") {
          loanSelectModel = v as SelectOptModel;
          loanSelect.text = loanSelectModel.name!;
        }
      }
    });
  }
}
