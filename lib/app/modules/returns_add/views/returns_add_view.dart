import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/input_select.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
                  // const SizedBox(height: 8),
                  // Text("Pilih Penanggung Jawab", style: textRegular),
                  // const SizedBox(height: 4),
                  // InputSelect(
                  //   hintText: "Pilih Penanggung Jawab",
                  //   onTap: () => controller.handleSelectOpt({
                  //     "title": "Pilih Penanggung Jawab",
                  //     "path": AppVariable.userAll,
                  //   }),
                  //   controller: controller.responsibilitySelect,
                  //   validator: (v) => valString!(v, "Penanggung Jawab"),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
