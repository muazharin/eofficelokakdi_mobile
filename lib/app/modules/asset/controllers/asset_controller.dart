import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetController extends GetxController {
  var isLoading = true;
  var isError = false;
  var error = '';
  var page = 1;
  var searchController = TextEditingController();
  var data = <AssetModel>[];

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void getAllData() async {
    isLoading = true;
    isError = false;
    error = "";
    data = [];
    page = 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.asset,
        queryParameters: {"search": searchController.text, "page": page},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        data = result['data']
            .map<AssetModel>((v) => AssetModel.fromJson(v))
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

  void handleDetailPage(AssetModel v) {
    Get.rootDelegate.toNamed(
      Routes.ASSET_DETAIL,
      arguments: {
        "satker_code": v.satker!.satkerCode,
        "stuff_code": v.stuff!.stuffCode,
        "nup": v.nup,
      },
    );
  }
}
