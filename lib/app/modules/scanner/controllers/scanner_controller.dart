import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerController extends GetxController {
  var qrKey = GlobalKey(debugLabel: 'QR');
  var parts = <String>[];
  var isFlashOn = false;
  QRViewController? qrController;

  void handleBackBtn() {
    Get.back();
  }

  void handleFlashBtn() async {
    await qrController!.toggleFlash();
    bool? status = await qrController?.getFlashStatus();
    isFlashOn = status ?? false;
    update();
  }

  void onQRViewCreated(QRViewController v) {
    qrController = v;
    qrController?.getFlashStatus().then((status) {
      isFlashOn = status ?? false;
      update();
    });
    v.scannedDataStream.listen((v) {
      parts = v.code!.split("*");
      update();
      switch (parts.length) {
        case 3:
          Get.offNamed(
            Routes.ASSET_DETAIL,
            arguments: {
              "satker_code": parts[0],
              "stuff_id": parts[1],
              "nup": parts[2],
            },
          );
          break;
        case 4:
          Get.offNamed(
            Routes.ASSET_DETAIL,
            arguments: {
              "satker_code": parts[1],
              "stuff_id": parts[2],
              "nup": parts[3],
            },
          );
          break;
        default:
          Get.back();
          snackbarWarning(message: "QR Code tidak valid");
      }
    });
  }
}
