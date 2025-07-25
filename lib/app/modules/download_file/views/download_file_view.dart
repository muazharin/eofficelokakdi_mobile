import 'package:eoffice/app/data/widgets/button_circle.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/download_file_controller.dart';

class DownloadFileView extends GetView<DownloadFileController> {
  const DownloadFileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<DownloadFileController>(
          builder: (context) {
            if (controller.isLoading) {
              return Obx(
                () => ButtonCircle(
                  txBtn: controller.downloadProgress.value == 0.0
                      ? "0.0 %"
                      : "${(controller.downloadProgress.value * 100).toStringAsFixed(1)} %",
                  onTap: () {},
                ),
              );
            }
            return ButtonCircle(
              txBtn: "Download\nSekarang!",
              onTap: () =>
                  controller.handleDownloadFile(controller.arg['file_path']),
            );
          },
        ),
      ),
    );
  }
}
