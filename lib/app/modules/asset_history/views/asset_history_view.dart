import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/asset_history_controller.dart';

class AssetHistoryView extends GetView<AssetHistoryController> {
  const AssetHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Histori Asset',
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<AssetHistoryController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(controller.error, style: textRegular),
              ),
            );
          } else if (controller.data.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Data tidak ditemukan!", style: textRegular),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => controller.getData(),
                  child: ListView(
                    children: [
                      ...controller.data.asMap().entries.map((v) {
                        return ExpansionTile(
                          title: Text(
                            DateFormat(
                              "dd MMMM yyyy",
                              "id",
                            ).format(v.value.assetHistoryDate!),
                            style: textRegular,
                          ),
                          children: [
                            ListTile(
                              title: Text(
                                v.value.assetNote!,
                                style: textRegular,
                              ),
                              subtitle: Text(
                                v.value.userHistory?.userName ?? "-",
                                style: textRegular,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
