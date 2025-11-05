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
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../controllers/returns_add_controller.dart';

class ReturnsAddView extends GetView<ReturnsAddController> {
  const ReturnsAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GetBuilder<ReturnsAddController>(
          builder: (context) {
            return Text(
              '${controller.title} Pengembalian',
              style: textSemiBold.copyWith(fontSize: 20),
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<ReturnsAddController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  Text("Pilih Peminjaman", style: textRegular),
                  const SizedBox(height: 4),
                  InputSelect(
                    hintText: "Pilih Peminjaman",
                    onTap: () => controller.handleLoanOpt({
                      "title": "Pilih Peminjaman",
                      "path":
                          "${AppVariable.returnsMyDataLoan}?user_id=${controller.userData["user_id"]}",
                    }),
                    controller: controller.loanSelect,
                    validator: (v) => valString!(v, "Peminjaman"),
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
                  Text("Tgl. Pengembalian", style: textRegular),
                  const SizedBox(height: 4),
                  InputDate(
                    hintText: "Tgl. Pengembalian",
                    controller: controller.returnDate,
                    onChanged: (v) {},
                    onTap: (v) =>
                        controller.handleSelectDate(v!, "Tgl. Pengembalian", 0),
                    validator: (v) => valString!(v, "Tgl. Pengembalian"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Form Kerusakan Kendaraan", style: textRegular),
                      InkWell(
                        child: Icon(Icons.add),
                        onTap: () => controller.addVehicleDamageForm(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  controller.vehicleDamageModel.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.black300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Tidak ada kerusakan",
                              style: textRegular.copyWith(
                                color: AppColor.black300,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  ...controller.vehicleDamageModel.asMap().entries.map((data) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.black300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    InputText(
                                      hintText: "Masukkan Item",
                                      controller: controller
                                          .vehicleDamageItem[data.key],
                                      onChanged: (v) =>
                                          controller.onChangedVehicleDamageForm(
                                            "Item",
                                            v,
                                            data.key,
                                          ),
                                      validator: (v) => valString!(v, "Item"),
                                    ),
                                    const SizedBox(height: 4),
                                    InputDate(
                                      hintText: "Waktu Kerusakan",
                                      controller: controller
                                          .vehicleDamageTime[data.key],
                                      onChanged: (v) {},
                                      isBirthDate: true,
                                      onTap: (v) => controller.handleSelectDate(
                                        v!,
                                        "Waktu Kerusakan",
                                        data.key,
                                      ),
                                      validator: (v) =>
                                          valString!(v, "Tgl. Peminjaman"),
                                    ),
                                    const SizedBox(height: 4),
                                    InputText(
                                      hintText: "Masukkan Jenis Kerusakan",
                                      controller: controller
                                          .vehicleDamageType[data.key],
                                      onChanged: (v) =>
                                          controller.onChangedVehicleDamageForm(
                                            "Jenis",
                                            v,
                                            data.key,
                                          ),
                                      validator: (v) =>
                                          valString!(v, "Jenis Kerusakan"),
                                    ),
                                    const SizedBox(height: 4),
                                    InputText(
                                      hintText: "Masukkan Keterangan",
                                      controller: controller
                                          .vehicleDamageNote[data.key],
                                      onChanged: (v) =>
                                          controller.onChangedVehicleDamageForm(
                                            "Ket",
                                            v,
                                            data.key,
                                          ),
                                      validator: (v) =>
                                          valString!(v, "Keterangan"),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.error500,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    Icons.remove_rounded,
                                    color: AppColor.error500,
                                  ),
                                ),
                                onTap: () =>
                                    controller.removeVehicleDamage(data.key),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    );
                  }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tanda Tangan", style: textRegular),
                      GestureDetector(
                        onTap: () => controller.clearPad(),
                        child: Text("Hapus", style: textRegular),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.black200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SfSignaturePad(
                      key: controller.signaturePadKey,
                      minimumStrokeWidth: 1,
                      maximumStrokeWidth: 4,
                      onDrawEnd: () => controller.onDrawEnd(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonDefault(
                    text: "Kirim",
                    color: controller.isAllowSubmit
                        ? AppColor.blue500
                        : AppColor.black200,
                    onTap: controller.isAllowSubmit
                        ? () => controller.handleSubmit()
                        : () {},
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
