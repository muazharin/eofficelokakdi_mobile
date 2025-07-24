import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AssetDetailController extends GetxController {
  var arg = Get.arguments;
  var isLoading = true;
  var isError = false;
  var error = "";
  var data = AssetModel();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    print("getData");
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
