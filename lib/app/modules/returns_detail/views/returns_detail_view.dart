import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/button_outlined.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../controllers/returns_detail_controller.dart';

class ReturnsDetailView extends GetView<ReturnsDetailController> {
  const ReturnsDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Detail Pengembalian',
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          GetBuilder<ReturnsDetailController>(
            builder: (context) {
              if (!controller.isAllowEdit) {
                return SizedBox();
              }
              return InkWell(
                onTap: () => controller.handleEdit(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Icon(Icons.edit_note_rounded),
                ),
              );
            },
          ),
        ],
      ),
      body: GetBuilder<ReturnsDetailController>(
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
                        "${controller.data.asset!.assetName!} (${controller.data.asset!.assetPoliceNo})",
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
                      ...controller.data.vehicleDamage!.map((v) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Text("Detail Kerusakan", style: textSemiBold),
                                const SizedBox(width: 8),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text("Item Kerusakan", style: textSemiBold),
                            Text(v.vehicleDamageItem!, style: textRegular),
                            const SizedBox(height: 8),
                            Text("Waktu Kerusakan", style: textSemiBold),
                            Text(
                              DateFormat(
                                "dd MMMM yyyy",
                              ).format(v.vehicleDamageTime!),
                              style: textRegular,
                            ),
                            const SizedBox(height: 8),
                            Text("Jenis Kerusakan", style: textSemiBold),
                            Text(v.vehicleDamageItem!, style: textRegular),
                            const SizedBox(height: 8),
                            Text("Keterangan", style: textSemiBold),
                            Text(v.vehicleDamageNote!, style: textRegular),
                            const SizedBox(height: 8),
                          ],
                        );
                      }),
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
                            color: AppColor.success500,
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
                controller.isShowApproval
                    ? Column(
                        children: [
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 8),
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
                            text: "Konfirmasi",
                            color: controller.isAllowSubmit
                                ? AppColor.blue500
                                : AppColor.black200,
                            onTap: () => controller.approval("Approve"),
                            radius: 12,
                          ),
                          const SizedBox(height: 8),
                          ButtonOutlined(
                            text: "Batalkan",
                            borderColor: AppColor.error500,
                            onTap: () => controller.approval("Decline"),
                          ),
                        ],
                      )
                    : const SizedBox(),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
