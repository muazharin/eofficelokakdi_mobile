import 'dart:convert';

import 'package:eoffice/app/data/models/asset_loan_detail.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:get/get.dart';

class ReturnLoanOptController extends GetxController {
  var arg = Get.arguments;
  var title = '';
  var isLoading = true;
  var isError = false;
  var error = '';
  var data = <AssetLoanDetailModel>[];

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
      if (result['status']) {
        data = (result['data'] as List)
            .map<AssetLoanDetailModel>((v) => AssetLoanDetailModel.fromJson(v))
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

  void handleBackButton(AssetLoanDetailModel? v) {
    Get.back(result: v);
  }
}
