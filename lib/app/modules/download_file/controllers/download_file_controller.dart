import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFileController extends GetxController {
  var arg = Get.arguments;
  var isLoading = false;
  var downloadProgress = 0.0.obs;

  Future<void> handleDownloadFile(String url, {String? filename}) async {
    isLoading = true;
    update();
    try {
      // Set directory
      Directory dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          dir =
              await getExternalStorageDirectory() ??
              await getApplicationDocumentsDirectory();
        }
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      // File path
      String name = filename ?? url.split('/').last.split('?').first;
      String savePath = '${dir.path}/$name';

      // Download
      Dio dio = Dio();
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress.value = received / total;
          }
        },
      );

      snackbarSuccess(message: "File downloaded to $savePath");
      Get.until((route) => Get.currentRoute == Routes.ASSET);
      await OpenFile.open(savePath);
    } catch (e) {
      snackbarDanger(message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
