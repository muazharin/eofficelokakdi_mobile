import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ReturnsController extends GetxController {
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var isLoading = true;
  var isError = false;
  var isAdmin = false;
  var error = '';
  var page = 1;
  // var data = <GroupAssetReturn>[];

  void handleAdd() {
    Get.toNamed(Routes.RETURNS_ADD)!.then((v) {
      // return getData();
    });
  }
}
