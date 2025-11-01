import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/borrow_detail_controller.dart';

class BorrowDetailView extends GetView<BorrowDetailController> {
  const BorrowDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Detail Peminjaman',
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          InkWell(
            onTap: () => controller.handleEdit(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.edit_note_rounded),
            ),
          ),
        ],
      ),
      body: GetBuilder<BorrowDetailController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Text("Detail Kegiatan", style: textSemiBold),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Kegiatan", style: textSemiBold),
                      Text(controller.data.eventName!, style: textRegular),
                      const SizedBox(height: 8),
                      Text("Tempat Kegiatan", style: textSemiBold),
                      Text(controller.data.eventPlace!, style: textRegular),
                      const SizedBox(height: 8),
                      Text("Tanggal Kegiatan", style: textSemiBold),
                      Text(
                        "${DateFormat("dd MMMM yyyy", "id").format(controller.data.eventDateStart!)}-${DateFormat("dd MMMM yyyy", "id").format(controller.data.eventDateFinish!)}",
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Anggota Tim", style: textSemiBold),
                      ...controller.data.members!.asMap().entries.map((v) {
                        return Text(
                          "${v.key + 1}.${v.value.memberName}",
                          style: textRegular,
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text("Detail Kendaraan", style: textSemiBold),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kendaraan", style: textSemiBold),
                      Text(
                        controller.data.asset!.assetName!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Kondisi Kendaraan", style: textSemiBold),
                      Text(
                        controller.data.vehicleCondition!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Kelengkapan Kendaraan", style: textSemiBold),
                      Text(
                        controller.data.vehicleEquipment!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Kondisi Kelengkapan", style: textSemiBold),
                      Text(
                        controller.data.vehicleEquipmentCondition!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Kondisi BBM", style: textSemiBold),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(16),
                        child: CachedNetworkImage(
                          height: 200,
                          width: Get.width,
                          fit: BoxFit.cover,
                          imageUrl: "${controller.data.fuelImage}",
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pemohon", style: textSemiBold),
                      Text(
                        controller.data.applicant!.applicantName!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Penanggung Jawab Kendaraan", style: textSemiBold),
                      Text(
                        controller.data.responsibility!.responsibilityName!,
                        style: textRegular,
                      ),
                      const SizedBox(height: 8),
                      Text("Lihat Dokumen", style: textSemiBold),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () =>
                            controller.openDoc(controller.data.docFile!),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColor.blue500,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.picture_as_pdf_rounded,
                                    color: AppColor.black100,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${controller.data.docFile!.split("/").last} ",
                                    style: textRegular.copyWith(
                                      color: AppColor.black100,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColor.black100,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
