import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/detail_list.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/asset_detail_controller.dart';

class AssetDetailView extends GetView<AssetDetailController> {
  const AssetDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Detail Asset', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          GetBuilder<AssetDetailController>(
            builder: (context) {
              if (!controller.isAdmin) {
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
      body: GetBuilder<AssetDetailController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text("Pemilik Barang", style: textSemiBold),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      DetailList(
                        name: "Kode Satker",
                        value: "${controller.data.assets!.satker!.satkerCode}",
                      ),
                      DetailList(
                        name: "Nama Satker",
                        value: "${controller.data.assets!.satker!.satkerName}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text("Identitas Barang", style: textSemiBold),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      DetailList(
                        name: "Kode Barang",
                        value: "${controller.data.assets!.stuff?.stuffId}",
                      ),
                      DetailList(
                        name: "NUP",
                        value: "${controller.data.assets!.nup}",
                      ),
                      DetailList(
                        name: "Nama Barang",
                        value: "${controller.data.assets!.stuff!.stuffName}",
                      ),
                      DetailList(
                        name: "Merk",
                        value: "${controller.data.assets!.merk}",
                      ),
                      DetailList(
                        name: "Jenis BMN",
                        value: "${controller.data.assets!.bmn!.bmnName}",
                      ),
                      DetailList(
                        name: "Tgl. Perolehan",
                        value: DateFormat(
                          "dd-MM-yyyy",
                          "id",
                        ).format(controller.data.assets!.firstBookDate!),
                      ),
                      DetailList(
                        name: "Kondisi",
                        value:
                            "${controller.data.assets!.condition?.conditionName}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("History Barang", style: textSemiBold),
                    InkWell(
                      child: Text("Lihat Semua", style: textSemiBold),
                      onTap: () => controller.listHistory(),
                    ),
                  ],
                ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Keterangan", style: textSemiBold),
                          const SizedBox(width: 8),
                          Expanded(child: Divider()),
                          const SizedBox(width: 8),
                          Switch(
                            value: controller.isShowNote,
                            onChanged: (v) => controller.onChanged(v),
                          ),
                        ],
                      ),
                      Text(
                        controller.data.assets!.note ?? "Belum ada keterangan",
                        style: textRegular,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Gambar Barang", style: textSemiBold),
                    controller.isEditImg
                        ? InkWell(
                            onTap: () => controller.handleSaveImg(),
                            child: Text("Simpan", style: textSemiBold),
                          )
                        : controller.files.isEmpty
                        ? const SizedBox()
                        : InkWell(
                            onTap: () => controller.handleEditImg(),
                            child: Text("Ubah", style: textSemiBold),
                          ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: controller.files.isEmpty
                      ? InkWell(
                          onTap: () => controller.handleAddImgBtn(),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(Icons.add_circle_outline_rounded),
                                const SizedBox(height: 8),
                                Text("Tambahkan sekarang", style: textRegular),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 56,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...controller.files.asMap().entries.map((v) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Badge(
                                    isLabelVisible: controller.isEditImg,
                                    label: InkWell(
                                      onTap: controller.isEditImg
                                          ? () => controller.handleRemoveImgBtn(
                                              v.key,
                                            )
                                          : () {},
                                      child: Icon(
                                        Icons.clear_rounded,
                                        size: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.handleShowImage(v.key),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(4),
                                        child: Image.file(
                                          v.value,
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              controller.isEditImg
                                  ? GestureDetector(
                                      onTap: () => controller.handleAddImgBtn(),
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Icon(Icons.add_rounded),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                Text("Lokasi Barang", style: textSemiBold),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.blue200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Pemilik Bangunan", style: textSemiBold),
                          const SizedBox(width: 8),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DetailList(
                        name: "Kode Satker",
                        value: "${controller.data.assets!.satker!.satkerCode}",
                      ),
                      DetailList(
                        name: "Nama Satker",
                        value: "${controller.data.assets!.satker!.satkerName}",
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            "Identitas Bangunan Gedung",
                            style: textSemiBold,
                          ),
                          const SizedBox(width: 8),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DetailList(
                        name: "Kode Barang",
                        value: "${controller.data.assets!.stuff?.stuffId}",
                      ),
                      DetailList(
                        name: "NUP",
                        value: "${controller.data.assets!.nup}",
                      ),
                      DetailList(
                        name: "Nama Barang",
                        value: "${controller.data.assets!.name}",
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text("Ruangan", style: textSemiBold),
                          const SizedBox(width: 8),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DetailList(
                        name: "Kode Ruangan",
                        value: controller.data.assets!.location?.locationId == 1
                            ? "-"
                            : controller.data.assets!.location!.locationName!
                                  .split(' - ')[0],
                      ),
                      DetailList(
                        name: "Nama Ruangan",
                        value: controller.data.assets!.location?.locationId == 1
                            ? controller.data.assets!.location!.locationName!
                            : controller.data.assets!.location!.locationName!
                                  .split(' - ')[1],
                      ),
                      DetailList(
                        name: "Keterangan",
                        value:
                            "${controller.data.assets!.usageStatus!.usageName}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
