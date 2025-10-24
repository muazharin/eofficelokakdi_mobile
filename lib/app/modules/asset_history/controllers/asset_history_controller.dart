import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:get/get.dart';

class AssetHistoryController extends GetxController {
  var arg = Get.arguments;
  var isLoading = true;
  var isError = false;
  var isAdmin = false;
  var error = '';
  var data = <AssetHistory>[];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    data = [];
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.assetHistory,
        queryParameters: {"asset_id": arg["asset_id"]},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        data = result['data']
            .map<AssetHistory>((v) => AssetHistory.fromJson(v))
            .toList();
      } else {
        data = [];
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
}
