import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/widgets/button_circle.dart';
import 'package:eoffice/app/data/widgets/button_outlined.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/download_file_controller.dart';

class DownloadFileView extends GetView<DownloadFileController> {
  const DownloadFileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Center(
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonCircle(
                            txBtn: "Download\nSekarang!",
                            onTap: () => controller.handleDownloadFile(
                              controller.arg['file_path'],
                            ),
                          ),
                          const SizedBox(height: 32),
                          ButtonOutlined(
                            text: "Batal",
                            borderColor: AppColor.blue500,
                            onTap: () => controller.handleBackBtn(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
