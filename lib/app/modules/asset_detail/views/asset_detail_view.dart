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
          InkWell(
            onTap: () => controller.handleEdit(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.edit_note_rounded),
            ),
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
                        value: "${controller.data.satker!.satkerCode}",
                      ),
                      DetailList(
                        name: "Nama Satker",
                        value: "${controller.data.satker!.satkerName}",
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
                        value: "${controller.data.stuff?.stuffId}",
                      ),
                      DetailList(name: "NUP", value: "${controller.data.nup}"),
                      DetailList(
                        name: "Nama Barang",
                        value: "${controller.data.stuff!.stuffName}",
                      ),
                      DetailList(
                        name: "Merk",
                        value: "${controller.data.merk}",
                      ),
                      DetailList(
                        name: "Jenis BMN",
                        value: "${controller.data.bmn!.bmnName}",
                      ),
                      DetailList(
                        name: "Tgl. Perolehan",
                        value: DateFormat(
                          "dd-MM-yyyy",
                        ).format(controller.data.firstBookDate!),
                      ),
                      DetailList(
                        name: "Kondisi",
                        value: "${controller.data.condition?.conditionName}",
                      ),
                    ],
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
                        value: "${controller.data.satker!.satkerCode}",
                      ),
                      DetailList(
                        name: "Nama Satker",
                        value: "${controller.data.satker!.satkerName}",
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
                        value: "${controller.data.stuff?.stuffId}",
                      ),
                      DetailList(name: "NUP", value: "${controller.data.nup}"),
                      DetailList(
                        name: "Nama Barang",
                        value: "${controller.data.name}",
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
                        value: controller.data.location?.locationId == 1
                            ? "-"
                            : controller.data.location!.locationName!.split(
                                ' - ',
                              )[0],
                      ),
                      DetailList(
                        name: "Nama Ruangan",
                        value: controller.data.location?.locationId == 1
                            ? controller.data.location!.locationName!
                            : controller.data.location!.locationName!.split(
                                ' - ',
                              )[1],
                      ),
                      DetailList(
                        name: "Keterangan",
                        value: "${controller.data.usageStatus!.usageName}",
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
