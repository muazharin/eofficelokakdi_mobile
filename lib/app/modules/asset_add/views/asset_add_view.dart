import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/input_date.dart';
import 'package:eoffice/app/data/widgets/input_select.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/asset_add_controller.dart';

class AssetAddView extends GetView<AssetAddController> {
  const AssetAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GetBuilder<AssetAddController>(
          builder: (context) {
            return Text(
              '${controller.title} Asset',
              style: textSemiBold.copyWith(fontSize: 20),
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackButton(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<AssetAddController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  Text("Jenis BMN", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Jenis BMN",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Jenis BMN",
                      "path": AppVariable.bmn,
                    }),
                    controller: controller.bmnName,
                    validator: (v) => valString!(v, "Jenis BMN"),
                  ),
                  const SizedBox(height: 8),
                  Text("Kode Barang", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Kode Barang",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Kode Barang",
                      "path": AppVariable.stuff,
                    }),
                    controller: controller.stuffCode,
                    validator: (v) => valString!(v, "Kode Barang"),
                  ),
                  const SizedBox(height: 8),
                  Text("NUP", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan NUP",
                    controller: controller.nup,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {},
                    validator: (v) => valNumber!(v, "NUP"),
                  ),
                  const SizedBox(height: 8),
                  Text("Merk", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Merk",
                    controller: controller.merk,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Merk"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tipe", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Tipe",
                    controller: controller.assetType,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Tipe"),
                  ),
                  const SizedBox(height: 8),
                  Text("Kondisi", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Kondisi",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Kondisi",
                      "path": AppVariable.condition,
                    }),
                    controller: controller.conditionName,
                    validator: (v) => valString!(v, "Kondisi"),
                  ),
                  const SizedBox(height: 8),
                  Text("Jenis Dokumen", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Jenis Dokumen",
                    controller: controller.documentType,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Jenis Dokumen"),
                  ),
                  const SizedBox(height: 8),
                  Text("No. Dokumen", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan No. Dokumen",
                    controller: controller.documentNo,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "No. Dokumen"),
                  ),
                  const SizedBox(height: 8),
                  Text("No. BPKP", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan No. BPKP",
                    controller: controller.bpkpNo,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "No. BPKP"),
                  ),
                  const SizedBox(height: 8),
                  controller.bmnName.text.isNotEmpty && controller.bmn.id == 3
                      ? InputText(
                          hintText: "Masukkan No. Polisi",
                          controller: controller.policeNo,
                          onChanged: (v) {},
                          validator: (v) => valString!(v, "No. Polisi"),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),
                  Text("Status Sertifikat", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Status Sertifikat",
                    controller: controller.certificateStatus,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Status Sertifikat"),
                  ),
                  const SizedBox(height: 8),
                  Text("No. Sertifikat", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan No. Sertifikat",
                    controller: controller.certificateNo,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "No. Sertifikat"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nama Barang", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nama Barang",
                    controller: controller.name,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Nama Barang"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tanggal Buku Pertama", style: textRegular),
                  const SizedBox(height: 4),
                  InputDate(
                    hintText: "Masukkan Tanggal Buku Pertama",
                    controller: controller.firstBookDate,
                    onChanged: (v) {},
                    isBirthDate: true,
                    onTap: (v) =>
                        controller.handleSelectDate(v!, "Tanggal Buku Pertama"),
                    validator: (v) => valString!(v, "Tanggal Buku Pertama"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tanggal Akuisisi", style: textRegular),
                  const SizedBox(height: 4),
                  InputDate(
                    hintText: "Masukkan Tanggal Akuisisi",
                    controller: controller.acquisitionDate,
                    onChanged: (v) {},
                    isBirthDate: true,
                    onTap: (v) =>
                        controller.handleSelectDate(v!, "Tanggal Akuisisi"),
                    validator: (v) => valString!(v, "Tanggal Akuisisi"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nilai Perolehan Pertama", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nilai Perolehan Pertama",
                    controller: controller.firstEarningValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: '',
                        decimalDigits: 0,
                      ),
                    ],
                    onChanged: (v) {},
                    validator: (v) => valNumber!(v, "Nilai Perolehan Pertama"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nilai Mutasi", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nilai Mutasi",
                    controller: controller.mutationValue,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {},
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: '',
                        decimalDigits: 0,
                      ),
                    ],
                    validator: (v) => valNumber!(v, "Nilai Mutasi"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nilai Perolehan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nilai Perolehan",
                    controller: controller.earnedValue,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {},
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: '',
                        decimalDigits: 0,
                      ),
                    ],
                    validator: (v) => valNumber!(v, "Nilai Perolehan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nilai Penyusutan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nilai Penyusutan",
                    controller: controller.depreciationValue,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {},
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: '',
                        decimalDigits: 0,
                      ),
                    ],
                    validator: (v) => valNumber!(v, "Nilai Penyusutan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Nilai Buku", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nilai Buku",
                    controller: controller.bookValue,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {},
                    inputFormatters: <TextInputFormatter>[
                      CurrencyTextInputFormatter.currency(
                        locale: 'id',
                        symbol: '',
                        decimalDigits: 0,
                      ),
                    ],
                    validator: (v) => valNumber!(v, "Nilai Buku"),
                  ),
                  const SizedBox(height: 8),
                  Text("Lokasi Ruang", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Lokasi Ruang",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Lokasi Ruang",
                      "path": AppVariable.location,
                    }),
                    controller: controller.locationName,
                    validator: (v) => valString!(v, "Lokasi Ruang"),
                  ),
                  const SizedBox(height: 8),
                  Text("Status Penggunaan", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Status Penggunaan",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Status Penggunaan",
                      "path": AppVariable.usagestatus,
                    }),
                    controller: controller.usageStatusName,
                    validator: (v) => valString!(v, "Status Penggunaan"),
                  ),
                  const SizedBox(height: 8),
                  controller.bmnName.text.isNotEmpty && controller.bmn.id == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Luas Tanah Seluruhnya", style: textRegular),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan Luas Tanah Seluruhnya",
                              controller: controller.totalArea,
                              onChanged: (v) {},
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ),
                              ],
                              validator: (v) =>
                                  valNumber!(v, "Luas Tanah Seluruhnya"),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Luas Tanah Untuk Bangunan",
                              style: textRegular,
                            ),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan Luas Tanah Untuk Bangunan",
                              controller: controller.landAreaForBuilding,
                              onChanged: (v) {},
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ),
                              ],
                              validator: (v) =>
                                  valNumber!(v, "Luas Tanah Untuk Bangunan"),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Luas Tanah Untuk Sarana Lingkungan",
                              style: textRegular,
                            ),
                            const SizedBox(height: 4),
                            InputText(
                              hintText:
                                  "Masukkan Luas Tanah Untuk Sarana Lingkungan",
                              controller: controller.landAreaForEnvFacilities,
                              onChanged: (v) {},
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ),
                              ],
                              validator: (v) => valNumber!(
                                v,
                                "Luas Tanah Untuk Sarana Lingkungan",
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text("Luas Tanah Kosong", style: textRegular),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan Luas Tanah Kosong",
                              controller: controller.vacantLandArea,
                              onChanged: (v) {},
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ),
                              ],
                              validator: (v) =>
                                  valNumber!(v, "Luas Tanah Kosong"),
                            ),
                            const SizedBox(height: 8),
                            Text("Luas Bangunan", style: textRegular),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan Luas Bangunan",
                              controller: controller.buildingLandArea,
                              onChanged: (v) {},
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                CurrencyTextInputFormatter.currency(
                                  locale: 'id',
                                  symbol: '',
                                  decimalDigits: 0,
                                ),
                              ],
                              validator: (v) => valNumber!(v, "Luas Bangunan"),
                            ),
                            const SizedBox(height: 8),
                            Text("Provinsi", style: textRegular),
                            const SizedBox(height: 4),
                            InputSelect(
                              hintText: "Pilih Provinsi",
                              onTap: () => controller.handleSelectOpt({
                                "title": "Provinsi",
                                "path": AppVariable.province,
                              }),
                              controller: controller.provinceName,
                              validator: (v) => valString!(v, "Provinsi"),
                            ),
                            const SizedBox(height: 8),
                            Text("Kota/Kab", style: textRegular),
                            const SizedBox(height: 4),
                            InputSelect(
                              hintText: "Pilih Kota/Kab",
                              onTap: () => controller.province.id == null
                                  ? snackbarWarning(
                                      message: "Pilih Provinsi terlebih dahulu",
                                    )
                                  : controller.handleSelectOpt({
                                      "title": "Kota/Kab",
                                      "path": AppVariable.city,
                                      "params": {
                                        "id_province": controller.province.id,
                                      },
                                    }),
                              controller: controller.cityName,
                              validator: (v) => valString!(v, "Kota/Kab"),
                            ),
                            const SizedBox(height: 8),
                            Text("Kecamatan", style: textRegular),
                            const SizedBox(height: 4),
                            InputSelect(
                              hintText: "Pilih Kecamatan",
                              onTap: () => controller.city.id == null
                                  ? snackbarWarning(
                                      message: "Pilih Kota/Kab terlebih dahulu",
                                    )
                                  : controller.handleSelectOpt({
                                      "title": "Kecamatan",
                                      "path": AppVariable.district,
                                      "params": {"id_city": controller.city.id},
                                    }),
                              controller: controller.districtName,
                              validator: (v) => valString!(v, "Kecamatan"),
                            ),
                            const SizedBox(height: 8),
                            Text("Kelurahan", style: textRegular),
                            const SizedBox(height: 4),
                            InputSelect(
                              hintText: "Pilih Kelurahan",
                              onTap: () => controller.district.id == null
                                  ? snackbarWarning(
                                      message:
                                          "Pilih Kecamatan terlebih dahulu",
                                    )
                                  : controller.handleSelectOpt({
                                      "title": "Kelurahan",
                                      "path": AppVariable.subdistrict,
                                      "params": {
                                        "id_district": controller.district.id,
                                      },
                                    }),
                              controller: controller.subdistrictName,
                              validator: (v) => valString!(v, "Kelurahan"),
                            ),
                            const SizedBox(height: 8),
                            Text("RT/RW", style: textRegular),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan RT/RW",
                              controller: controller.rtRw,
                              onChanged: (v) {},
                              validator: (v) => valString!(v, "RT/RW"),
                            ),
                            const SizedBox(height: 8),
                            Text("Alamat", style: textRegular),
                            const SizedBox(height: 4),
                            InputText(
                              hintText: "Masukkan Alamat",
                              controller: controller.address,
                              onChanged: (v) {},
                              minLines: 4,
                              maxLines: 4,
                              validator: (v) => valString!(v, "Alamat"),
                            ),
                            const SizedBox(height: 8),
                          ],
                        )
                      : const SizedBox(),
                  Text("Jumlah Foto", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Jumlah Foto",
                    controller: controller.noOfPhotos,
                    onChanged: (v) {},
                    validator: (v) => valNumber!(v, "Jumlah Foto"),
                  ),
                  const SizedBox(height: 8),
                  Text("No. PSP", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan No. PSP",
                    controller: controller.pspNo,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "No. PSP"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tanggal PSP", style: textRegular),
                  const SizedBox(height: 4),
                  InputDate(
                    hintText: "Masukkan Tanggal PSP",
                    controller: controller.pspDate,
                    isBirthDate: true,
                    onChanged: (v) {},
                    onTap: (v) =>
                        controller.handleSelectDate(v!, "Tanggal PSP"),
                    validator: (v) => valString!(v, "Tanggal PSP"),
                  ),
                  const SizedBox(height: 8),
                  Text("Kode Pos", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Kode Pos",
                    controller: controller.postalCode,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Kode Pos"),
                  ),
                  const SizedBox(height: 8),
                  Text("SBSK", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan SBSK",
                    controller: controller.sbsk,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "SBSK"),
                  ),
                  const SizedBox(height: 8),
                  Text("Keterangan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Keterangan",
                    controller: controller.note,
                    onChanged: (v) {},
                    minLines: 4,
                    maxLines: 4,
                    validator: (v) => valString!(v, "Keterangan"),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Simpan",
                    color: AppColor.blue500,
                    onTap: () => controller.handleSubmit(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
