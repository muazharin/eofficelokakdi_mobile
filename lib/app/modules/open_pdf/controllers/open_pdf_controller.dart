import 'package:eoffice/app/data/services/service.dart';
import 'package:get/get.dart';
import 'package:pdfx/pdfx.dart';

class OpenPdfController extends GetxController {
  var arg = Get.arguments as String;
  var isLoading = false;
  PdfControllerPinch? pdfController;
  @override
  void onInit() {
    setFile();
    super.onInit();
  }

  void setFile() {
    isLoading = true;
    update();
    AppService().createFileFromUrl(arg).then((f) {
      pdfController = PdfControllerPinch(
        document: PdfDocument.openFile(f.path),
      );
      isLoading = false;
      update();
    });
  }
}
