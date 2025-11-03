import 'dart:convert';
import 'dart:io';
// ignore: unnecessary_import
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:eoffice/app/data/services/service.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:eoffice/app/data/models/asset_loan_detail.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/loading_custom.dart';
import 'package:eoffice/app/data/widgets/pop_up_option.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class BorrowDetailController extends GetxController {
  var arg = Get.arguments;
  var box = SecureStorageService();
  var isLoading = true;
  var isError = false;
  var error = "";
  var data = AssetLoanDetailModel();
  var userData = <String, dynamic>{};
  var signaturePadKey = GlobalKey<SfSignaturePadState>();
  var isShowApproval = false;
  var isAllowSubmit = false;
  var isAllowEdit = false;
  Uint8List? bytePad;
  File? imgPad;
  Uint8List? applicantPad;
  Uint8List? responsibilityPad;
  Uint8List? fuelImage;

  @override
  void onInit() async {
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading = true;
    isError = false;
    error = "";
    update();
    try {
      final response = await Api().getWithToken(
        path: AppVariable.loanDetail,
        queryParameters: {"asset_loan_id": arg['asset_loan_id']},
      );
      var result = jsonDecode(response.toString());
      if (result["status"]) {
        data = AssetLoanDetailModel.fromJson(result["data"]);
        isLoading = false;
        cekSignPad();
        update();
      } else {
        isError = true;
        isLoading = false;
        error = result["message"];
      }
    } catch (e) {
      print(e);
      isError = true;
      isLoading = false;
      error = e.toString();
      update();
    }
  }

  void cekSignPad() async {
    isShowApproval = false;
    if (data.responsibility!.responsibilityId! ==
        int.parse(userData['user_id'])) {
      isShowApproval = true;
      print("data.responsibility!.responsibilityApproval!");
      print(data);
      if (data.responsibility!.responsibilityApproval! != "-") {
        isShowApproval = false;
      }
    } else if (userData["user_id"] == "3") {
      isShowApproval = true;
      if (data.bos!.bosApproval != "-") {
        isShowApproval = false;
      }
    }
    isAllowEdit = false;
    if (data.applicant!.applicantId == int.parse(userData["user_id"]) &&
        data.responsibility!.responsibilityApproval == "-") {
      isAllowEdit = true;
    }

    applicantPad = await AppService().createByteFromUrl(
      data.applicant!.applicantPad!,
    );

    fuelImage = await AppService().createByteFromUrl(data.fuelImage!);

    if (data.responsibility!.responsibilityPad!.isNotEmpty) {
      responsibilityPad = await AppService().createByteFromUrl(
        data.responsibility!.responsibilityPad!,
      );
    }
    update();
  }

  void openDoc(String path) {
    Get.toNamed(Routes.OPEN_PDF, arguments: path);
  }

  void handleEdit() {
    Get.toNamed(Routes.BORROW_ADD, arguments: {"data": data});
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
    isAllowSubmit = true;
    update();
  }

  void approval(String v) {
    Get.dialog(
      PopUpOption(
        title: "Approval",
        detail:
            "Anda yakin ingin ${v == "Approve" ? "mengizinkan" : "membatalkan"}?",
        onTap: () {
          Get.back();
          doApproval(v);
        },
      ),
    );
  }

  void doApproval(String v) async {
    loadingPage(message: "Sedang men-generate dokumen...");
    if (v == "Approve") {
      var pdf = pw.Document();
      var root = await getExternalStorageDirectory();
      var imageKop = (await rootBundle.load(
        "assets/png/kop.png",
      )).buffer.asUint8List();
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
                pw.Text("Kepada Yth:"),
                pw.Text("Kepala Loka Monitor SFR Kendari"),
                pw.Text("di-"),
                pw.Text("Tempat"),
                pw.SizedBox(height: .5 * PdfPageFormat.cm),
                pw.Paragraph(
                  text:
                      "\t\t\t\tDalam rangka melaksanakan kegiatan :\n${data.eventName}",
                  style: pw.TextStyle(lineSpacing: 1),
                ),
                pw.Text(
                  "Maka yang bertanda tangan di bawah ini (mewakili tim pelaksana kegiatan):",
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
                    ["Nama ", ": ${data.applicant!.applicantName}"],
                    ["NIP ", ": ${data.applicant!.applicantNip}"],
                    [
                      "Pangkat ",
                      ": ${data.applicant!.applicantLevel}/${data.applicant!.applicantGol}",
                    ],
                    ["Jabatan ", ": ${data.applicant!.applicantPosition}"],
                  ],
                ),
                pw.SizedBox(height: .5 * PdfPageFormat.cm),
                pw.Paragraph(
                  text:
                      "Dengan ini mengajukan permohonan peminjaman BMN berupa kendaraan dinas operasional roda empat ${data.asset!.assetName} ${data.asset!.assetPoliceNo}, untuk pelaksanaan kegiatan sesuai dengan yang dimaksud diatas. Adapun anggota tim, waktu dan tempat pelaksanaan kegiatan tersebut sebagai berikut  : ",
                  style: pw.TextStyle(lineSpacing: 1),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(flex: 1, child: pw.Text("Anggota Tim")),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(": "),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: data.members!
                                    .asMap()
                                    .entries
                                    .map(
                                      (v) => pw.Text(
                                        "${v.key + 1}. ${v.value.memberName}",
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(flex: 1, child: pw.Text("Tempat Kegiatan")),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Text(": ${data.eventPlace}"),
                        ),
                      ],
                    ),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(flex: 1, child: pw.Text("Waktu")),
                        pw.Expanded(
                          flex: 4,
                          child: pw.Text(
                            ": ${DateFormat("dd MMMM yyyy", "id").format(data.eventDateStart!)}-${DateFormat("dd MMMM yyyy", "id").format(data.eventDateFinish!)}",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: .5 * PdfPageFormat.cm),
                pw.Paragraph(
                  text:
                      "Kami pelaksana kegiatan akan bertanggung jawab atas keamanan dan kondisi BMN kendaraan operasional yang akan digunakan.",
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
                      "Kendari, ${DateFormat("dd MMMM yyyy", "id").format(data.loanDate!)}",
                    ],
                    [
                      pw.Text(
                        "Kepala Loka Monitor Spektrum\nFrekuensi Radio Kendari",
                        textAlign: pw.TextAlign.center,
                      ),
                      "Pemohon",
                    ],
                    [
                      pw.SizedBox(
                        height: 90,
                        child: userData["user_id"] == "3"
                            ? pw.Image(pw.MemoryImage(bytePad!), height: 80)
                            : pw.SizedBox(),
                      ),
                      pw.SizedBox(
                        height: 90,
                        child: pw.Image(
                          pw.MemoryImage(applicantPad!),
                          height: 80,
                        ),
                      ),
                    ],
                    [
                      "Boby Satriyo Suleman",
                      "${data.applicant!.applicantName}",
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      );

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
                      "FORMULIR PEMINJAMAN KENDARAAN",
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
                    ["Nama ", ": ${data.applicant!.applicantName}"],
                    ["NIP ", ": ${data.applicant!.applicantNip}"],
                    [
                      "Pangkat ",
                      ": ${data.applicant!.applicantLevel}/${data.applicant!.applicantGol}",
                    ],
                    ["Jabatan ", ": ${data.applicant!.applicantPosition}"],
                    [
                      "Pada Hari, Tanggal ",
                      ": ${DateFormat('EEEE, dd MMMM yyyy', "id").format(data.loanDate!)}",
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
                          "${data.asset!.assetName}\n${data.asset!.assetPoliceNo}",
                          "${data.vehicleEquipment} ",
                          "${data.vehicleEquipmentCondition} ",
                          pw.Image(
                            pw.MemoryImage(fuelImage!),
                            height: 50,
                            fit: pw.BoxFit.cover,
                          ),
                          "${data.vehicleCondition} ",
                        ],
                      )
                      .toList(),
                ),
                pw.SizedBox(height: .5 * PdfPageFormat.cm),
                pw.Paragraph(
                  text:
                      "Telah melakukan pengecekan kondisi dan kelengkapan kendaraan sesuai dengan data diatas dan akan menggunakan kendaraan sesuai dengan tugas kedinasan yang diberikan oleh Kepala kantor Loka Monitor Kendari.",
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
                      "Kendari, ${DateFormat('dd MMMM yyyy', 'id').format(data.loanDate!)}",
                    ],
                    ["Penanggung Jawab Kendaraan", "Peminjam Kendaraan"],
                    [
                      pw.SizedBox(
                        height: 100,
                        child: userData["user_id"] == "3"
                            ? pw.Image(
                                pw.MemoryImage(responsibilityPad!),
                                height: 80,
                              )
                            : pw.Image(pw.MemoryImage(bytePad!), height: 80),
                      ),
                      pw.SizedBox(
                        height: 90,
                        child: pw.Image(
                          pw.MemoryImage(applicantPad!),
                          height: 80,
                        ),
                      ),
                    ],
                    [
                      "${data.responsibility!.responsibilityName}",
                      "${data.applicant!.applicantName}",
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
                    [
                      "",
                      pw.SizedBox(
                        height: 90,
                        child: userData["user_id"] == "3"
                            ? pw.Image(pw.MemoryImage(bytePad!), height: 80)
                            : pw.SizedBox(),
                      ),
                      "",
                    ],
                    ["", "Boby Satriyo Suleman", ""],
                  ],
                ),
              ],
            ),
          ],
        ),
      );

      var file = File(
        // '${root!.path}/${DateTime.now().microsecondsSinceEpoch}.pdf',
        '${root!.path}/peminjaman.pdf',
      );
      await file.writeAsBytes(await pdf.save());
      // await OpenFile.open(file.path);

      try {
        final response = await Api().putWithToken(
          path: AppVariable.loanApproval,
          queryParameters: {"asset_loan_id": data.assetLoanId},
          data: FormData.fromMap({
            "approval_pad": await MultipartFile.fromFile(imgPad!.path),
            "approval_doc": await MultipartFile.fromFile(file.path),
            "approval_type": userData["user_id"] == "3"
                ? "Bos"
                : "Responsibility",
            "approval_result": v,
          }),
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.back();
          getData();
          snackbarSuccess(message: "Berhasil menyimpan data");
        } else {
          Get.back();
          snackbarDanger(message: result['message']);
        }
      } catch (e) {
        Get.back();
        snackbarDanger(message: e.toString());
      }
    } else {
      try {
        final response = await Api().putWithToken(
          path: AppVariable.loanApproval,
          queryParameters: {"asset_loan_id": data.assetLoanId},
          data: FormData.fromMap({
            "approval_type": userData["user_id"] == "3"
                ? "Bos"
                : "Responsibility",
            "approval_result": v,
          }),
        );
        var result = jsonDecode(response.toString());
        if (result['status']) {
          Get.back();
          getData();
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
}
