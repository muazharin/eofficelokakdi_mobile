import 'dart:convert';

import 'package:eoffice/app/data/models/asset_loan_detail.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';

class BorrowDetailController extends GetxController {
  var arg = Get.arguments;
  var box = SecureStorageService();
  var isLoading = true;
  var isError = false;
  var error = "";
  var data = AssetLoanDetailModel();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.loanDetail,
        queryParameters: {"asset_loan_id": arg['asset_loan_id']},
      );
      var result = jsonDecode(response.toString());
      if (result["status"]) {
        data = AssetLoanDetailModel.fromJson(result["data"]);
        isLoading = false;
        update();
      } else {
        isError = true;
        isLoading = false;
        error = result["message"];
      }
    } catch (e) {
      isError = true;
      isLoading = false;
      error = e.toString();
      update();
    }
  }

  void openDoc(String path) {
    Get.toNamed(Routes.OPEN_PDF, arguments: path);
  }
}
