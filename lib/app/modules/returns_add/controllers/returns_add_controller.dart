import 'dart:io';
import 'dart:typed_data';

import 'package:eoffice/app/data/models/asset_loan_detail.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/services/service.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReturnsAddController extends GetxController {
  var title = "Ajukan";
  var key = GlobalKey<FormState>();
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var loanSelect = TextEditingController();
  var loanSelectModel = AssetLoanDetailModel();
  var responsibilitySelect = TextEditingController();
  var responsibilitySelectModel = SelectOptModel();
  var isAllowSubmit = false;
  Uint8List? bytePad;
  File? imgPad;
  File? fuelImage;

  @override
  void onInit() async {
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
    super.onInit();
  }

  void handleLoanOpt(dynamic arg) {
    Get.toNamed(Routes.RETURN_LOAN_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        if (arg["title"] == "Pilih Peminjaman") {
          loanSelectModel = v as AssetLoanDetailModel;
          loanSelect.text = loanSelectModel.asset!.assetName!;
        }
      }
    });
  }

  void handleSelectOpt(dynamic arg) {
    Get.toNamed(Routes.SELECT_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        if (arg["title"] == "Pilih Penanggung Jawab") {
          responsibilitySelectModel = v as SelectOptModel;
          responsibilitySelect.text = loanSelectModel.asset!.assetName!;
        }
      }
    });
  }

  void handleAddImgBtn() {
    showOptionsBottomSheet(
      menu: [
        MenuModel(
          name: "Camera",
          iconData: Icons.camera_alt_outlined,
          onTap: () => getImage(ImageSource.camera),
        ),
        MenuModel(
          name: "Galeri",
          iconData: Icons.photo,
          onTap: () => getImage(ImageSource.gallery),
        ),
      ],
    );
  }

  void getImage(ImageSource source) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    fuelImage = await AppService().compressImage(File(image.path));
    if (bytePad != null) {
      isAllowSubmit = true;
    }
    update();
  }

  void handleRemoveImgBtn() {
    fuelImage = null;
    update();
  }
}
