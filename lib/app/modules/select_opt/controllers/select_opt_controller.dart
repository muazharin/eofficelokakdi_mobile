import 'dart:convert';

import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:get/get.dart';

class SelectOptController extends GetxController {
  var arg = Get.arguments;
  var title = '';
  var isLoading = true;
  var isError = false;
  var error = '';
  var data = <SelectOptModel>[];

  @override
  void onInit() {
    handleArguments();
    super.onInit();
  }

  void handleArguments() {
    title = arg['title'];
    getAllData(arg['path'], arg['params']);
    update();
  }

  void getAllData(String? path, Map<String, dynamic>? queryParameters) async {
    isLoading = true;
    data = [];
    update();
    try {
      final response = await Api().getWithToken(
        path: path,
        queryParameters: queryParameters,
      );
      var result = jsonDecode(response.toString());
      print(result);
      if (result['status']) {
        data = (result['data'] as List)
            .map<SelectOptModel>((v) => SelectOptModel.fromJson(v))
            .toList();
      } else {
        data = [];
      }
      isLoading = false;
      update();
    } catch (e) {
      isError = true;
      isLoading = false;
      error = e.toString();
      update();
    }
  }

  void handleBackButton(SelectOptModel? v) {
    Get.back(result: v);
  }
}
