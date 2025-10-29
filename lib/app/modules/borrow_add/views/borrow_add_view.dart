import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/input_date.dart';
import 'package:eoffice/app/data/widgets/input_select.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/borrow_add_controller.dart';

class BorrowAddView extends GetView<BorrowAddController> {
  const BorrowAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Ajukan Peminjaman',
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<BorrowAddController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  Text("Nama Kegiatan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Nama Kegiatan",
                    controller: controller.eventName,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Nama Kegiatan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tempat Kegiatan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Tempat Kegiatan",
                    controller: controller.eventPlace,
                    minLines: 2,
                    maxLines: 2,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Tempat Kegiatan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Tgl. Kegiatan", style: textRegular),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: InputDate(
                          hintText: "Mulai",
                          controller: controller.eventDateStart,
                          onChanged: (v) {},
                          onTap: (v) =>
                              controller.handleSelectDate(v!, "Tgl. Mulai"),
                          validator: (v) => valString!(v, "Tgl. Mulai"),
                        ),
                      ),
                      Text(" - ", style: textRegular),
                      Expanded(
                        child: InputDate(
                          hintText: "Selesai",
                          controller: controller.eventDateFinish,
                          onChanged: (v) {},
                          onTap: (v) =>
                              controller.handleSelectDate(v!, "Tgl. Selesai"),
                          validator: (v) => valString!(v, "Tgl. Selesai"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Kendaraan", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Kendaraan",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Pilih Kendaraan",
                      "path": "${AppVariable.asset}?bmn_id=3&stuff_id=&page=1",
                    }),
                    controller: controller.bmnSelect,
                    validator: (v) => valString!(v, "Kendaraan"),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Anggota", style: textRegular),
                      InkWell(
                        child: Icon(Icons.add),
                        onTap: () => controller.addAnggota(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  controller.anggotaModel.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.black300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Tidak ada anggota ditambahkan",
                              style: textRegular.copyWith(
                                color: AppColor.black300,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  ...controller.anggotaModel.asMap().entries.map((data) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InputSelect(
                                hintText: "Pilih Anggota",
                                onTap: () => controller.handleSelectOpt({
                                  "title": "Pilih Anggota",
                                  "path": AppVariable.userAll,
                                  "index": data.key,
                                }),
                                controller: controller.anggota[data.key],
                                validator: (v) => valString!(v, "Anggota"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.error500),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.remove_rounded,
                                  color: AppColor.error500,
                                ),
                              ),
                              onTap: () => controller.removeAnggota(data.key),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  }),
                  Text("Tgl. Peminjaman", style: textRegular),
                  const SizedBox(height: 4),
                  InputDate(
                    hintText: "Tgl. Peminjaman",
                    controller: controller.loanDate,
                    onChanged: (v) {},
                    onTap: (v) =>
                        controller.handleSelectDate(v!, "Tgl. Peminjaman"),
                    validator: (v) => valString!(v, "Tgl. Peminjaman"),
                  ),
                  const SizedBox(height: 8),
                  Text("Kelengkapan Kendaraan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Kelengkapan Kendaraan",
                    controller: controller.vehicleEquipment,
                    minLines: 2,
                    maxLines: 2,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Kelengkapan Kendaraan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Kondisi Kelengkapan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Kondisi Kelengkapan",
                    controller: controller.vehicleEquipmentCondition,
                    minLines: 2,
                    maxLines: 2,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Kondisi Kelengkapan"),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kondisi BBM", style: textRegular),
                      controller.fuelImage == null
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () => controller.handleRemoveImgBtn(),
                              child: Row(
                                children: [
                                  Text(
                                    "Hapus",
                                    style: textRegular.copyWith(
                                      color: AppColor.error600,
                                    ),
                                  ),
                                  Icon(
                                    Icons.delete_outline_outlined,
                                    color: AppColor.error600,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => controller.handleAddImgBtn(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.black300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: controller.fuelImage == null
                            ? Column(
                                children: [
                                  Icon(Icons.add, color: AppColor.black300),
                                  Text(
                                    "Foto Kondisi BBM",
                                    style: textRegular.copyWith(
                                      color: AppColor.black300,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 200,
                                width: Get.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    controller.fuelImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Kondisi Kendaraan", style: textRegular),
                  const SizedBox(height: 4),
                  InputText(
                    hintText: "Masukkan Kondisi Kendaraan",
                    controller: controller.vehicleCondition,
                    minLines: 2,
                    maxLines: 2,
                    onChanged: (v) {},
                    validator: (v) => valString!(v, "Kondisi Kendaraan"),
                  ),
                  const SizedBox(height: 8),
                  Text("Penanggung Jawab Kendaraan", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Penanggung Jawab",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Pilih Penanggung Jawab",
                      "path": AppVariable.userAll,
                    }),
                    controller: controller.responsibilitySelect,
                    validator: (v) => valString!(v, "Penanggung Jawab"),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Generate",
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
