import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackbarSuccess({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    duration: const Duration(seconds: 1),
    backgroundColor: AppColor.success600,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 128 : 16,
      36,
      snackPosition == SnackPosition.TOP ? 16 : 128,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: Colors.white),
    ),
    icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 15),
  );
}

void snackbarWarning({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    duration: const Duration(seconds: 1),
    backgroundColor: AppColor.yellow700,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 128 : 16,
      36,
      snackPosition == SnackPosition.BOTTOM ? 16 : 128,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: Colors.white),
    ),
    icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 15),
  );
}

// void snackbarDanger({String? message}) {
//   Get.dialog(
//     PopUpDelete(
//       title: "Gagal",
//       detail: message,
//       isShowButton: false,
//       isShowIcon: true,
//     ),
//   );
// }
void snackbarDanger({
  String? message,
  SnackPosition? snackPosition = SnackPosition.TOP,
}) {
  Get.rawSnackbar(
    duration: const Duration(seconds: 1),
    backgroundColor: AppColor.error600,
    borderRadius: 12,
    shouldIconPulse: false,
    snackPosition: snackPosition!,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
    margin: EdgeInsets.fromLTRB(
      36,
      snackPosition == SnackPosition.TOP ? 128 : 16,
      36,
      snackPosition == SnackPosition.BOTTOM ? 16 : 128,
    ),
    messageText: Text(
      "$message",
      style: textRegular.copyWith(color: Colors.white),
    ),
    icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 15),
  );
}
