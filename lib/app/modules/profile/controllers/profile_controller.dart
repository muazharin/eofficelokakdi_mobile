import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/models/user.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/loading_custom.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileController extends GetxController {
  var box = SecureStorageService();
  var isLoading = true;
  var isError = false;
  var isShowMore = false;
  var error = "";
  var keyForm = GlobalKey<FormState>();
  var data = UserModel();
  var password = TextEditingController();
  var passwordC = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    update();
    try {
      var userId = JwtDecoder.decode((await box.getData('token'))!)['user_id'];
      final response = await Api().getWithToken(
        path: AppVariable.user,
        queryParameters: {"user_id": userId},
      );
      var result = jsonDecode(response.toString());
      print(result);
      if (result['status']) {
        data = UserModel.fromJson(result['data']);
      } else {
        isError = true;
        error = result['message'];
      }
      isLoading = false;
      update();
    } catch (e) {
      isError = true;
      error = e.toString();
      isLoading = false;
      update();
    }
  }

  void setShowMore() {
    isShowMore = !isShowMore;
    update();
  }

  void handleUpdatePhoto() {
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
    loadingPage(message: "Sedang memproses...");
    try {
      var userId = JwtDecoder.decode((await box.getData('token'))!)['user_id'];
      final response = await Api().putFileToken(
        path: AppVariable.userPhoto,
        data: FormData.fromMap({
          "user_photo": await MultipartFile.fromFile(image.path),
        }),
        queryParameters: {"user_id": userId},
      );
      var result = jsonDecode(response.toString());
      Get.back();
      if (result['status']) {
        box.saveData("token", result['token']);
        snackbarSuccess(message: "Foto berhasil diperbaharui");
        getData();
      } else {
        snackbarDanger(message: result["message"]);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: e.toString());
    }
  }

  void handleSubmit() async {
    if (keyForm.currentState!.validate()) {
      loadingPage(message: "Sedang memproses...");
      try {
        var userId = JwtDecoder.decode(
          (await box.getData('token'))!,
        )['user_id'];
        final response = await Api().putWithToken(
          path: AppVariable.userPassword,
          data: {"password": password.text},
          queryParameters: {"user_id": userId},
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.back();
          password.text = "";
          passwordC.text = "";
          update();
          snackbarSuccess(message: result['message']);
        } else {
          Get.back();
          snackbarDanger(message: result['message']);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: e.toString());
      }
    }
  }

  void handleShowPhoto(List<String> img) {
    Get.toNamed(Routes.PHOTO, arguments: {"images": img});
  }

  void handleEditBtn() {
    Get.toNamed(Routes.PROFILE_EDIT, arguments: {"data": data})!.then((_) {
      getData();
    });
  }
}
