import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/services/service.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/loading_custom.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/data/widgets/pop_up_option.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart' hide AssetImage;
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';

class AssetDetailController extends GetxController {
  var arg = Get.arguments;
  var isLoading = true;
  var isError = false;
  var isAdmin = false;
  var isEditImg = false;
  var isShowNote = false;
  var error = "";
  var data = AssetParentModel();
  var box = SecureStorageService();
  var files = <File>[];
  var scrollController = ScrollController();

  @override
  void onInit() {
    getData();
    checkIsAdmin();
    super.onInit();
  }

  void checkIsAdmin() async {
    var role = JwtDecoder.decode((await box.getData('token'))!)['user_role'];
    isAdmin = role == "1";
    update();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.assetByParams,
        queryParameters: {
          "satker_code": arg["satker_code"],
          "stuff_id": arg["stuff_id"],
          "nup": arg["nup"],
        },
      );
      var result = jsonDecode(response.toString());
      if (result["status"]) {
        data = AssetParentModel.fromJson(result["data"]);
        isShowNote = data.assets!.isShowNote == "Yes";
        isLoading = false;
        update();
        setFileImage(data.assetImages!);
      } else {
        isError = true;
        isLoading = false;
        error = result["message"];
        update();
      }
    } catch (e) {
      isError = true;
      isLoading = false;
      error = e.toString();
      update();
    }
  }

  void onChanged(bool v) {
    print(v);
    if (!v) {
      Get.dialog(
        PopUpOption(
          title: "Notif Keterangan",
          detail: "Anda yakin ingin mengubah?",
          onTap: () {
            Get.back();
            doChange(v);
          },
        ),
      );
    } else {
      doChange(v);
    }
  }

  void doChange(bool v) async {
    try {
      loadingPage(message: "Sedang mengubah...");
      final response = await Api().putWithToken(
        path: AppVariable.assetShowNote,
        queryParameters: {"asset_id": data.assets!.assetId},
        data: {"asset_show_note": v ? "Yes" : "No"},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        isShowNote = v;
        update();
        Get.back();
        snackbarSuccess(message: "Berhasil mengubah");
      } else {
        Get.back();
        snackbarDanger(message: result['message']);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: e.toString());
    }
  }

  void setFileImage(List<AssetImage> data) async {
    final directory = await getTemporaryDirectory();

    for (int i = 0; i < data.length; i++) {
      final response = await http.get(Uri.parse(data[i].assetFile!));
      final filePath = '${directory.path}/image_$i.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      files.add(file);
      update();
    }
  }

  void handleEdit() {
    Get.toNamed(Routes.ASSET_ADD, arguments: data.assets);
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

  void handleRemoveImgBtn(int index) {
    files.removeAt(index);
    update();
  }

  void getImage(ImageSource source) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    var compressImage = await AppService().compressImage(File(image.path));
    files.add(compressImage!);
    isEditImg = true;
    update();
  }

  void handleSaveImg() async {
    var assetImgFile = <MultipartFile>[];
    for (var e in files) {
      assetImgFile.add(await MultipartFile.fromFile(e.path));
    }
    try {
      loadingPage(message: "Sedang menyimpan...");
      final response = await Api().putFileToken(
        path: AppVariable.assetUploadImg,
        queryParameters: {"asset_id": data.assets!.assetId},
        data: FormData.fromMap({"asset_image_file": assetImgFile}),
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        isEditImg = false;
        update();
        Get.back();
        snackbarSuccess(message: "Berhasil menyimpan gambar");
      } else {
        Get.back();
        snackbarDanger(message: result['message']);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: e.toString());
    }
  }

  void handleEditImg() {
    isEditImg = true;
    update();
  }

  void handleShowImage(int index) {
    Get.toNamed(
      Routes.PHOTO,
      arguments: {
        "images": files.map((v) => v.path).toList(),
        "img_type": "file",
        "index": index,
      },
    );
  }

  void listHistory() {
    Get.toNamed(
      Routes.ASSET_HISTORY,
      arguments: {"asset_id": data.assets!.assetId},
    );
  }
}
