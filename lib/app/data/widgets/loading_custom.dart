import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loadingPage({String? message}) {
  Get.generalDialog(
    pageBuilder: (context, i, j) => PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              const SizedBox(height: 16),
              Text(
                message ?? "Menunggu...",
                textAlign: TextAlign.center,
                style: textRegular.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
