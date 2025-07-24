import 'dart:convert';

import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:get/get.dart';

class AssetFilterController extends GetxController {
  var arg = Get.arguments;
  var listBmns = <SelectOptModel>[];
  var listStuffs = <SelectOptModel>[];
  var selectedBmn = SelectOptModel();
  var selectedStuff = SelectOptModel();
  var isLoading = true;
  var isError = false;
  var title = 'Asset';

  @override
  void onInit() {
    getListBmns();
    getListStruffs();

    super.onInit();
  }

  void handleArguments() {
    selectedBmn = (arg['bmn'] as SelectOptModel);
    selectedStuff = (arg['stuff'] as SelectOptModel);
    update();
  }

  void getListBmns() async {
    try {
      isLoading = true;
      update();
      final response = await Api().getWithToken(path: AppVariable.bmn);
      var result = jsonDecode(response.toString());
      if (result['status']) {
        listBmns = (result['data'] as List)
            .map<SelectOptModel>((v) => SelectOptModel.fromJson(v))
            .toList();
        isLoading = false;
        update();
      } else {
        isError = true;
        isLoading = false;
        update();
      }
    } catch (e) {
      isError = true;
      update();
    } finally {
      handleArguments();
    }
  }

  void getListStruffs() async {
    try {
      isLoading = true;
      update();
      final response = await Api().getWithToken(path: AppVariable.stuff);
      var result = jsonDecode(response.toString());
      if (result['status']) {
        listStuffs = (result['data'] as List)
            .map<SelectOptModel>((v) => SelectOptModel.fromJson(v))
            .toList();
        isLoading = false;
        update();
      } else {
        isError = true;
        isLoading = false;
        update();
      }
    } catch (e) {
      isError = true;
      update();
    } finally {
      handleArguments();
    }
  }

  void handleBackButton() {
    Get.back(result: {"bmn": selectedBmn, "stuff": selectedStuff});
  }

  void handleSelectBmn(SelectOptModel v) {
    selectedBmn = v;
    update();
  }

  void handleSelectStuff(SelectOptModel v) {
    selectedStuff = v;
    update();
  }

  void handleClearFilter() {
    selectedBmn = SelectOptModel();
    selectedStuff = SelectOptModel();
    update();
  }
}
