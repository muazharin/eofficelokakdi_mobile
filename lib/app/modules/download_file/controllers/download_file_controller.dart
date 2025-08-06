import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadFileController extends GetxController {
  var arg = Get.arguments;
  var isLoading = false;
  var downloadProgress = 0.0.obs;

  void handleBackBtn() {
    Get.back();
  }

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
      update();

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

      snackbarSuccess(message: "File berhasil di download");
      Get.until((route) => Get.currentRoute == Routes.ASSET);
      showOptionsBottomSheet(
        menu: [
          MenuModel(
            name: "Buka",
            iconData: Icons.file_open_outlined,
            onTap: () async => await OpenFile.open(savePath),
          ),
          MenuModel(
            name: "Kirim",
            iconData: Icons.share_rounded,
            onTap: () async => await SharePlus.instance.share(
              ShareParams(text: "name", files: [XFile(savePath)]),
            ),
          ),
        ],
      );
    } catch (e) {
      snackbarDanger(message: e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
