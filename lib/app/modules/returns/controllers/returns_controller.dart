import 'dart:convert';
// ignore: depend_on_referenced_packages
import "package:collection/collection.dart";
import 'package:eoffice/app/data/models/asset_return.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ReturnsController extends GetxController {
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var isLoading = true;
  var isError = false;
  var isAdmin = false;
  var error = '';
  var page = 1;
  var data = <GroupAssetReturn>[];

  @override
  void onInit() async {
    userData = JwtDecoder.decode((await box.getData("token"))!);
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    data = [];
    page = 1;
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.returns,
        queryParameters: {
          "page": page,
          "role": userData["user_role"],
          "user_id": userData["user_id"],
        },
      );

      var result = jsonDecode(response.toString());
      if (result['status']) {
        var list = result['data']
            .map<AssetReturnModel>((v) => AssetReturnModel.fromJson(v))
            .toList();
        groupBy(list, (AssetReturnModel assetReturn) {
          return DateFormat('MMMM yyyy', 'id').format(assetReturn.returnDate!);
        }).forEach((key, value) {
          data.add(GroupAssetReturn(name: key, riwayat: value));
        });
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
        path: AppVariable.returns,
        queryParameters: {
          "page": page,
          "role": userData["user_role"],
          "user_id": userData["user_id"],
        },
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var newData = result['data']
            .map<AssetReturnModel>((v) => AssetReturnModel.fromJson(v))
            .toList();
        data.addAll(newData);
      }
      update();
    } catch (_) {}
  }

  void handleAdd() {
    Get.toNamed(Routes.RETURNS_ADD)!.then((v) => getData());
  }

  void handleDetail(int id) {
    Get.toNamed(Routes.RETURNS_DETAIL, arguments: {"asset_return_id": id});
  }
}
