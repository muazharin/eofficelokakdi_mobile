import 'dart:async';
import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/loading_custom.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class AssetController extends GetxController {
  var isLoading = true;
  var isError = false;
  var error = '';
  var isVisibleBadge = false;
  var sumVisibleBadge = 0;
  var page = 1;
  var searchController = TextEditingController();
  var data = <AssetModel>[];
  var selectedBmn = SelectOptModel();
  var selectedStuff = SelectOptModel();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  var isDialOpen = ValueNotifier(false);

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void handleSearch(String v) {
    debouncer.call(() {
      getAllData();
    });
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
        queryParameters: {
          "bmn_id": selectedBmn.id,
          "stuff_id": selectedStuff.id,
          "search": searchController.text,
          "page": page,
        },
      );
      var result = jsonDecode(response.toString());
      print(result);
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

  void handleLoadMore() async {
    page = page + 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.asset,
        queryParameters: {"search": searchController.text, "page": page},
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var newData = result['data']
            .map<AssetModel>((v) => AssetModel.fromJson(v))
            .toList();
        data.addAll(newData);
      }
      update();
    } catch (_) {}
  }

  void handleDetailPage(AssetModel v) {
    Get.toNamed(
      Routes.ASSET_DETAIL,
      arguments: {
        "satker_code": v.satker!.satkerCode,
        "stuff_id": v.stuff!.stuffId,
        "nup": v.nup,
      },
    );
  }

  void handleAddButton() {
    isDialOpen.value = !isDialOpen.value;
    update();
    Timer(Duration(milliseconds: 500), () => Get.toNamed(Routes.ASSET_ADD));
  }

  void handleFilterBtn() {
    Get.toNamed(
      Routes.ASSET_FILTER,
      arguments: {"bmn": selectedBmn, "stuff": selectedStuff},
    )!.then((v) {
      if (v != null) {
        selectedBmn = (v['bmn'] as SelectOptModel);
        selectedStuff = (v['stuff'] as SelectOptModel);
        update();
        getAllData();
      }
      handleBadge();
    });
  }

  void handleBadge() {
    sumVisibleBadge = 0;
    update();
    if (selectedBmn.id != null) {
      sumVisibleBadge += 1;
      update();
    }
    if (selectedStuff.id != null) {
      sumVisibleBadge += 1;
      update();
    }
    isVisibleBadge = sumVisibleBadge > 0;
    update();
  }

  void handleScanner() {
    isDialOpen.value = !isDialOpen.value;
    update();
    Timer(Duration(milliseconds: 500), () => Get.toNamed(Routes.SCANNER));
  }

  void handleDownloadFile() async {
    isDialOpen.value = !isDialOpen.value;
    update();
    // Timer(Duration(milliseconds: 500), () => Get.toNamed(Routes.DOWNLOAD_FILE));
    loadingPage(message: "Sedang menyiapkan file...");
    try {
      final response = await Api().getWithToken(
        path: AppVariable.assetDownload,
      );

      var result = jsonDecode(response.toString());
      if (result['status']) {
        Get.back();
        Get.toNamed(
          Routes.DOWNLOAD_FILE,
          arguments: {"file_path": result['data']['file_path']},
        );
      } else {
        Get.back();
        snackbarDanger(message: "Gagal menyiapkan file download");
      }
    } catch (_) {
      Get.back();
      snackbarDanger(message: "Gagal menyiapkan file download");
    }
  }
}
