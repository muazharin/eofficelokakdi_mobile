import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AssetDetailController extends GetxController {
  var arg = Get.arguments;
  var isLoading = true;
  var isError = false;
  var isAdmin = false;
  var error = "";
  var data = AssetModel();
  var box = SecureStorageService();

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
        data = AssetModel.fromJson(result["data"]);
        isLoading = false;
        update();
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

  void handleEdit() {
    Get.toNamed(Routes.ASSET_ADD, arguments: data);
  }
}
