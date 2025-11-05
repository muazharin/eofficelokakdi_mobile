import 'dart:convert';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/models/asset_loan_detail.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/models/vehicle_damage.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/services/service.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/loading_custom.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ReturnsAddController extends GetxController {
  var title = "Ajukan";
  var key = GlobalKey<FormState>();
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var loanSelect = TextEditingController();
  var loanSelectModel = AssetLoanDetailModel();
  var returnDate = TextEditingController();
  var returnDateFormat = DateTime.now();
  var vehicleEquipment = TextEditingController();
  var vehicleEquipmentCondition = TextEditingController();
  var vehicleCondition = TextEditingController();
  var vehicleDamageModel = <VehicleDamageModel>[];
  var vehicleDamageItem = <TextEditingController>[];
  var vehicleDamageTimeFormat = <DateTime>[];
  var vehicleDamageTime = <TextEditingController>[];
  var vehicleDamageType = <TextEditingController>[];
  var vehicleDamageNote = <TextEditingController>[];
  var signaturePadKey = GlobalKey<SfSignaturePadState>();
  var isAllowSubmit = false;
  Uint8List? bytePad;
  File? imgPad;
  File? fuelImage;

  @override
  void onInit() async {
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
    setDummy();
    super.onInit();
  }

  void setDummy() {
    vehicleEquipment.text = "Ban Serep, Kunci Roda, Telescopic, Rak Perangkat";
    vehicleEquipmentCondition.text = "Lengkap";
    vehicleCondition.text = "Kendaraan dalam Kondisi Baik";
    returnDate.text = "05-11-2025";
    returnDateFormat = DateTime.now();
    update();
  }

  void addVehicleDamageForm() {
    vehicleDamageModel.add(VehicleDamageModel());
    vehicleDamageItem.add(TextEditingController());
    vehicleDamageTimeFormat.add(DateTime.now());
    vehicleDamageTime.add(TextEditingController());
    vehicleDamageType.add(TextEditingController());
    vehicleDamageNote.add(TextEditingController());
    update();
  }

  void removeVehicleDamage(int i) {
    vehicleDamageModel.removeAt(i);
    vehicleDamageItem.removeAt(i);
    vehicleDamageTimeFormat.removeAt(i);
    vehicleDamageTime.removeAt(i);
    vehicleDamageType.removeAt(i);
    vehicleDamageNote.removeAt(i);
    update();
  }

  void onChangedVehicleDamageForm(String name, String value, int i) {
    switch (name) {
      case "Item":
        vehicleDamageModel[i].vehicleDamageItem = value;
        break;
      case "Jenis":
        vehicleDamageModel[i].vehicleDamageType = value;
        break;
      case "Ket":
        vehicleDamageModel[i].vehicleDamageNote = value;
        break;
      default:
    }
  }

  void handleLoanOpt(dynamic arg) {
    Get.toNamed(Routes.RETURN_LOAN_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        if (arg["title"] == "Pilih Peminjaman") {
          loanSelectModel = v as AssetLoanDetailModel;
          loanSelect.text = loanSelectModel.asset!.assetName!;
        }
      }
    });
  }

  void handleSelectDate(DateTime v, String name, int i) {
    switch (name) {
      case "Waktu Kerusakan":
        vehicleDamageTime[i].text = DateFormat("dd-MM-yyyy").format(v);
        vehicleDamageTimeFormat[i] = v;
        vehicleDamageModel[i].vehicleDamageTime = v;
        break;
      case "Tgl. Pengembalian":
        returnDate.text = DateFormat("dd-MM-yyyy").format(v);
        returnDateFormat = v;
        break;
      default:
    }
    update();
  }

  void clearPad() {
    signaturePadKey.currentState!.clear();
    isAllowSubmit = false;
    update();
  }

  void onDrawEnd() async {
    ui.Image img = await signaturePadKey.currentState!.toImage();
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    bytePad = byteData!.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );
    var dir = await getApplicationDocumentsDirectory();
    imgPad = File("${dir.path}/img_pad.png");
    await imgPad!.writeAsBytes(bytePad!, flush: true);
    if (fuelImage != null) {
      isAllowSubmit = true;
    }
    update();
  }

  void handleAddImgBtn() {
    showOptionsBottomSheet(
      menu: [
        MenuModel(
          name: "Camera",
          iconData: Icons.camera_alt_outlined,
          onTap: () => getImage(ImageSource.camera),
        ),
        MenuModel(
          name: "Galeri",
          iconData: Icons.photo,
          onTap: () => getImage(ImageSource.gallery),
        ),
      ],
    );
  }

  void getImage(ImageSource source) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    fuelImage = await AppService().compressImage(File(image.path));
    if (bytePad != null) {
      isAllowSubmit = true;
    }
    update();
  }

  void handleRemoveImgBtn() {
    fuelImage = null;
    update();
  }

  void handleSubmit() {
    if (key.currentState!.validate()) {
      doSubmit();
    }
  }

  void doSubmit() async {
    loadingPage(message: "Sedang men-generate dokumen...");
    var pdf = pw.Document();
    var root = await getExternalStorageDirectory();
    var imageKop = (await rootBundle.load(
      "assets/png/kop.png",
    )).buffer.asUint8List();
    var fuelImg = pw.MemoryImage(fuelImage!.readAsBytesSync());
    update();

    // Page 1
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.fromLTRB(
          0.98 * PdfPageFormat.inch,
          0.39 * PdfPageFormat.inch,
          0.59 * PdfPageFormat.inch,
          0.49 * PdfPageFormat.inch,
        ),
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Image(pw.MemoryImage(imageKop)),
        build: (_) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "FORMULIR PENGEMBALIAN KENDARAAN",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text:
                    "Saya yang bertanda tangan dibawah ini (mewakili tim pelaksana kegiatan sesuai dengan surat permohonan peminjaman kendaraan diatas ) :",
                style: pw.TextStyle(lineSpacing: 1),
              ),
              pw.TableHelper.fromTextArray(
                tableWidth: pw.TableWidth.min,
                cellPadding: pw.EdgeInsets.all(0),
                border: pw.TableBorder.all(
                  width: 0,
                  color: PdfColor.fromHex("#FFF"),
                ),
                data: [
                  ["", ""],
                  ["Nama ", ": ${userData['user_name']}"],
                  ["NIP ", ": ${userData['user_nip']}"],
                  [
                    "Pangkat ",
                    ": ${userData['user_level']}/${userData['user_gol']}",
                  ],
                  ["Jabatan ", ": ${userData['user_position']}"],
                  [
                    "Pada Hari, Tanggal ",
                    ": ${DateFormat('EEEE, dd MMMM yyyy', "id").format(returnDateFormat)}",
                  ],
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.TableHelper.fromTextArray(
                tableWidth: pw.TableWidth.max,
                cellAlignment: pw.Alignment.center,
                border: pw.TableBorder.all(width: 1),
                columnWidths: {
                  0: pw.FlexColumnWidth(.15),
                  1: pw.FlexColumnWidth(.2),
                  2: pw.FlexColumnWidth(.15),
                  3: pw.FlexColumnWidth(.15),
                  4: pw.FlexColumnWidth(.15),
                },

                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: [
                  pw.Text(
                    "Jenis Kendaraan (Merek/Type/ No.Plat)",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Daftar Kelengkapan Kendaraan",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Kondisi Kelengkapan Kendaraan",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Kondisi BBM",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Kondisi Kendaraan",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
                data: [1]
                    .map(
                      (_) => [
                        "${loanSelectModel.asset!.assetName}\n${loanSelectModel.asset!.assetPoliceNo}",
                        "${vehicleEquipment.text} ",
                        "${vehicleEquipmentCondition.text} ",
                        pw.Image(fuelImg, height: 50, fit: pw.BoxFit.cover),
                        "${vehicleCondition.text} ",
                      ],
                    )
                    .toList(),
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text:
                    "Kami akan bertanggungjawab atas keamanan dan kondisi kendaraan operasional roda empat yang telah digunakan oleh tim pelaksana kegiatan.",
                style: pw.TextStyle(lineSpacing: 1),
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.TableHelper.fromTextArray(
                tableWidth: pw.TableWidth.max,
                cellPadding: pw.EdgeInsets.all(0),
                cellAlignment: pw.Alignment.center,
                border: pw.TableBorder.all(
                  width: 0,
                  color: PdfColor.fromHex("#FFF"),
                ),
                data: [
                  [
                    "\n\n",
                    "Kendari, ${DateFormat('dd MMMM yyyy', 'id').format(returnDateFormat)}",
                  ],
                  ["Penanggung Jawab Kendaraan", "Peminjam Kendaraan"],
                  [
                    pw.SizedBox(height: 100),
                    pw.SizedBox(
                      height: 80,
                      child: pw.Image(pw.MemoryImage(bytePad!), height: 70),
                    ),
                  ],
                  [
                    "${loanSelectModel.responsibility!.responsibilityName}",
                    "${userData['user_name']}",
                  ],
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.TableHelper.fromTextArray(
                tableWidth: pw.TableWidth.max,
                cellPadding: pw.EdgeInsets.all(0),
                cellAlignment: pw.Alignment.center,
                border: pw.TableBorder.all(
                  width: 0,
                  color: PdfColor.fromHex("#FFF"),
                ),
                data: [
                  ["", "Mengetahui", ""],
                  ["", "Kepala Loka Monitor Spektrum", ""],
                  ["", "Frekuensi radio Kendari", ""],
                  ["", pw.SizedBox(height: 60), ""],
                  ["", "Boby Satriyo Suleman", ""],
                ],
              ),
            ],
          ),
        ],
      ),
    );

    // Page 2
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.fromLTRB(
          0.98 * PdfPageFormat.inch,
          0.39 * PdfPageFormat.inch,
          0.59 * PdfPageFormat.inch,
          0.49 * PdfPageFormat.inch,
        ),
        pageFormat: PdfPageFormat.a4,
        header: (context) => pw.Image(pw.MemoryImage(imageKop)),
        build: (_) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Expanded(child: pw.Text("")),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text(
                        "LAPORAN KONDISI KERUSAKAN KENDARAAN OPERASIONAL",
                      ),
                      pw.Text(
                        "${loanSelectModel.asset!.assetName} ${loanSelectModel.asset!.assetPoliceNo}",
                      ),
                    ],
                  ),
                  pw.Expanded(child: pw.Text("")),
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.TableHelper.fromTextArray(
                tableWidth: pw.TableWidth.max,
                cellAlignment: pw.Alignment.center,
                border: pw.TableBorder.all(width: 1),
                columnWidths: {
                  0: pw.FlexColumnWidth(.30),
                  1: pw.FlexColumnWidth(.25),
                  2: pw.FlexColumnWidth(.25),
                  3: pw.FlexColumnWidth(.20),
                },
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: [
                  pw.Text(
                    "Nama Item/Komponen Yang Rusak",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Waktu Kerusakan",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Jenis Kerusakan",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    "Ket",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
                data: vehicleDamageModel.isEmpty
                    ? [1]
                          .map(
                            (v) => [
                              pw.SizedBox(height: 60),
                              pw.SizedBox(height: 60),
                              pw.SizedBox(height: 60),
                              pw.SizedBox(height: 60),
                            ],
                          )
                          .toList()
                    : vehicleDamageModel
                          .map(
                            (v) => [
                              v.vehicleDamageItem,
                              // DateFormat(
                              //   "dd MMMM yyyy",
                              // ).format(v.vehicleDamageTime!),
                              "",
                              v.vehicleDamageType,
                              v.vehicleDamageNote,
                            ],
                          )
                          .toList(),
              ),
            ],
          ),
        ],
      ),
    );
    var file = File('${root!.path}/pengembalian.pdf');
    await file.writeAsBytes(await pdf.save());
    // await OpenFile.open(file.path);

    var vehicleDamage = <Map<String, dynamic>>[];
    for (var e in vehicleDamageModel) {
      vehicleDamage.add({
        "vehicle_damage_item": e.vehicleDamageItem,
        "vehicle_damage_time": DateFormat(
          "yyyy-MM-dd",
        ).format(e.vehicleDamageTime!),
        "vehicle_damage_type": e.vehicleDamageType,
        "vehicle_damage_note": e.vehicleDamageNote,
      });
    }

    try {
      final response = await Api().postWithToken(
        path: AppVariable.returns,
        data: FormData.fromMap({
          "asset_loan_id": loanSelectModel.assetLoanId,
          "asset_id": loanSelectModel.asset!.assetId,
          "applicant_id": loanSelectModel.applicant!.applicantId,
          "responsibility_id": loanSelectModel.responsibility!.responsibilityId,
          "return_date": DateFormat("yyyy-MM-dd").format(returnDateFormat),
          "vehicle_equipment": vehicleEquipment.text,
          "vehicle_equipment_condition": vehicleEquipmentCondition.text,
          "vehicle_condition": vehicleCondition.text,
          "fuel_image": await MultipartFile.fromFile(fuelImage!.path),
          "doc_file": await MultipartFile.fromFile(file.path),
          "applicant_pad": await MultipartFile.fromFile(imgPad!.path),
          "vehicle_damage": jsonEncode(vehicleDamage),
        }),
      );
      var result = jsonDecode(response.toString());
      if (result['status']) {
        Get.until((route) => Get.currentRoute == Routes.RETURNS);
        snackbarSuccess(message: "Berhasil menyimpan data");
      } else {
        Get.back();
        snackbarDanger(message: result['message']);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: e.toString());
    }
  }
}
