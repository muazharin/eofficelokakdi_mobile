import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BorrowController extends GetxController {
  void onSubmit() async {
    var pdf = pw.Document();
    var root = await getExternalStorageDirectory();
    var imageKop = (await rootBundle.load(
      "assets/png/kop.png",
    )).buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.fromLTRB(
          0.98 * PdfPageFormat.inch,
          0.39 * PdfPageFormat.inch,
          0.59 * PdfPageFormat.inch,
          0.49 * PdfPageFormat.inch,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (_) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Page 1
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Text("Kepada Yth:"),
              pw.Text("Kepala Loka Monitor SFR Kendari"),
              pw.Text("di-"),
              pw.Text("Tempat"),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text: "Dalam rangka melaksanakan kegiatan :\n<<Kegiatan>>",
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
                  ["Nama ", ": <<Nama Pemohon>>"],
                  ["NIP ", ": <<NIP>>"],
                  ["Pangkat ", ": <<Pangkat>>"],
                  ["Jabatan ", ": <<Jabatan>>"],
                ],
              ),
              pw.SizedBox(height: .5 * PdfPageFormat.cm),
              pw.Paragraph(
                text:
                    "Dengan ini mengajukan permohonan peminjaman BMN berupa kendaraan dinas operasional roda empat <<Jenis Kendaraan>> <<Plat Nomor>>, untuk pelaksanaan kegiatan sesuai dengan yang dimaksud diatas. Adapun anggota tim, waktu dan tempat pelaksanaan kegiatan tersebut sebagai berikut  : ",
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
                              children: [1, 1, 1, 1, 1]
                                  .asMap()
                                  .entries
                                  .map(
                                    (v) => pw.Text("<<Anggota ${v.key + 1}>>"),
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
                      pw.Expanded(flex: 4, child: pw.Text(": <<Tempat>>")),
                    ],
                  ),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(flex: 1, child: pw.Text("Waktu")),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          ": <<Tanggal Mulai Kegiatan1>>-<<Tanggal Akhir Kegiatan1>>",
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
                  ["\n\n", "Kendari, <<Tanggal Peminjaman1>>"],
                  ["Kepala Loka Monitor Spektrum", "Pemohon"],
                  ["Frekuensi Radio Kendari\n\n\n\n\n\n", ""],
                  ["Boby Satriyo Suleman", "<<Nama Pemohon>>"],
                ],
              ),
              // Page 2
              pw.Text("\n\n\n\n\n"),
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
                  ["Nama ", ": <<Nama Pemohon>>"],
                  ["NIP ", ": <<NIP>>"],
                  ["Pangkat ", ": <<Pangkat>>"],
                  ["Jabatan ", ": <<Jabatan>>"],
                  [
                    "Pada Hari, Tanggal ",
                    ": <<Hari Pinjam>>,<<Tanggal Peminjaman1>>",
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
                        "<<Jenis\nKendaraan>>\n<<Plat Nomor>> ",
                        "<<Daftar Kelengkapan\nKendaraan>>",
                        "<<Kondisi\nKelengkapan\nKendaraan>>",
                        "<<photoid1>>",
                        "<<Kondisi\nKendaraan>>",
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
                  ["\n\n", "Kendari, <<Tanggal Peminjaman1>>"],
                  ["Penanggung Jawab Kendaraan", "Peminjam Kendaraan"],
                  ["\n\n\n\n\n", ""],
                  ["<<Penanggung Jawab Kendaraan>>", "<<Nama Pemohon>>"],
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
        header: (context) => pw.Image(pw.MemoryImage(imageKop)),
      ),
    );

    var file = File('${root!.path}/test_pdf.pdf');
    await file.writeAsBytes(await pdf.save());
    await OpenFile.open(file.path);
  }
}
