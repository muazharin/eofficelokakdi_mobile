import 'dart:io';

import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/services/service.dart';
import 'package:eoffice/app/data/widgets/option_bottom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BorrowAddController extends GetxController {
  var box = SecureStorageService();
  var userData = <String, dynamic>{};
  var eventName = TextEditingController();
  var eventPlace = TextEditingController();
  var eventDateStart = TextEditingController();
  var eventDateStartFormat = DateTime.now();
  var eventDateFinish = TextEditingController();
  var eventDateFinishFormat = DateTime.now();
  var bmnSelect = TextEditingController();
  var bmnSelectModel = SelectOptModel();
  var anggotaModel = <SelectOptModel>[];
  var anggota = <TextEditingController>[];
  var loanDate = TextEditingController();
  var loanDateFormat = DateTime.now();
  var vehicleEquipment = TextEditingController();
  var vehicleEquipmentCondition = TextEditingController();
  var vehicleCondition = TextEditingController();
  var responsibilitySelect = TextEditingController();
  var responsibilitySelectModel = SelectOptModel();
  File? fuelImage;

  @override
  void onInit() async {
    addAnggota();
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
    super.onInit();
  }

  void handleSelectDate(DateTime v, String name) {
    switch (name) {
      case "Tgl. Mulai":
        eventDateStart.text = DateFormat("dd-MM-yyyy").format(v);
        eventDateStartFormat = v;
        break;
      case "Tgl. Selesai":
        eventDateFinish.text = DateFormat("dd-MM-yyyy").format(v);
        eventDateFinishFormat = v;
        break;
      case "Tgl. Peminjaman":
        loanDate.text = DateFormat("dd-MM-yyyy").format(v);
        loanDateFormat = v;
        break;
      default:
    }
  }

  void addAnggota() {
    anggotaModel.add(SelectOptModel());
    anggota.add(TextEditingController());
    update();
  }

  void removeAnggota(int i) {
    anggotaModel.removeAt(i);
    anggota.removeAt(i);
    update();
  }

  void handleSelectOpt(dynamic arg) {
    Get.toNamed(Routes.SELECT_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        if (arg["title"] == "Pilih Anggota") {
          anggotaModel[arg['index']] = v as SelectOptModel;
          anggota[arg['index']].text = anggotaModel[arg['index']].name!;
        } else if (arg["title"] == "Pilih Kendaraan") {
          bmnSelectModel = v as SelectOptModel;
          bmnSelect.text = bmnSelectModel.name!;
        } else if (arg['title'] == "Pilih Penanggung Jawab") {
          responsibilitySelectModel = v as SelectOptModel;
          responsibilitySelect.text = responsibilitySelectModel.name!;
        }
        update();
      }
    });
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

  void handleRemoveImgBtn() {
    fuelImage = null;
    update();
  }

  void getImage(ImageSource source) async {
    Get.back();
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    fuelImage = await AppService().compressImage(File(image.path));
    update();
  }

  void handleSubmit() async {
    var pdf = pw.Document();
    var root = await getExternalStorageDirectory();
    var imageKop = (await rootBundle.load(
      "assets/png/kop.png",
    )).buffer.asUint8List();

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
                    "\t\t\t\tDalam rangka melaksanakan kegiatan :\n${eventName.text}",
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
                  ["Nama ", ": ${userData['user_name']}"],
                  ["NIP ", ": ${userData['user_nip']}"],
                  [
                    "Pangkat ",
                    ": ${userData['user_level']}/${userData['user_gol']}",
                  ],
                  ["Jabatan ", ": ${userData['user_position']}"],
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text:
                    "Dengan ini mengajukan permohonan peminjaman BMN berupa kendaraan dinas operasional roda empat ${bmnSelectModel.name} ${bmnSelectModel.policeNo}, untuk pelaksanaan kegiatan sesuai dengan yang dimaksud diatas. Adapun anggota tim, waktu dan tempat pelaksanaan kegiatan tersebut sebagai berikut  : ",
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
                              children: anggotaModel
                                  .asMap()
                                  .entries
                                  .map(
                                    (v) => pw.Text(
                                      "${v.key + 1}. ${v.value.name}",
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
                        child: pw.Text(": ${eventPlace.text}"),
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
                          ": ${DateFormat("dd MMMM yyyy", "id").format(eventDateStartFormat)}-${DateFormat("dd MMMM yyyy", "id").format(eventDateFinishFormat)}",
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
                    "Kendari, ${DateFormat("dd MMMM yyyy", "id").format(loanDateFormat)}",
                  ],
                  ["Kepala Loka Monitor Spektrum", "Pemohon"],
                  ["Frekuensi Radio Kendari\n\n\n\n\n\n", ""],
                  ["Boby Satriyo Suleman", "${userData['user_name']}"],
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
                    ": ${DateFormat('EEEE, dd MMMM yyyy', "id").format(loanDateFormat)}",
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
                  "Jenis Kendaraan (Merek/Type/ No.Plat)",
                  "Daftar Kelengkapan Kendaraan",
                  "Kondisi Kelengkapan Kendaraan",
                  "Kondisi BBM",
                  "Kondisi Kendaraan",
                ],
                data: [1]
                    .map(
                      (_) => [
                        "${bmnSelectModel.name}\n${bmnSelectModel.policeNo}",
                        "${vehicleEquipment.text} ",
                        "${vehicleEquipmentCondition.text} ",
                        "<<photoid1>>",
                        "${vehicleCondition.text} ",
                      ],
                    )
                    .toList(),
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text:
                    "Telah melakukan pengecekan kondisi dan kelengkapan kendaraan sesuai dengan data diatas dan akan menggunakan kendaraan sesuai dengan tugas kedinasan yang diberikan oleh Kepala kantor Loka Monitor Kendari.",
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
                    "Kendari, ${DateFormat('dd MMMM yyyy', 'id').format(loanDateFormat)}",
                  ],
                  ["Penanggung Jawab Kendaraan", "Peminjam Kendaraan"],
                  ["\n\n\n\n\n", ""],
                  [
                    "${responsibilitySelectModel.name}",
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
                  ["", "\n\n\n\n\n", ""],
                  ["", "Boby Satriyo Suleman", ""],
                ],
              ),
            ],
          ),
        ],
      ),
    );

    var file = File('${root!.path}/test_pdf.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
}
