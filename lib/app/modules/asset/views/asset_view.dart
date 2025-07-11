import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/asset_controller.dart';

class AssetView extends GetView<AssetController> {
  const AssetView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Asset', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.rootDelegate.popRoute(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          Padding(padding: const EdgeInsets.all(16), child: Icon(Icons.tune)),
        ],
      ),
      body: GetBuilder<AssetController>(
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
          return ListView(
            children: [
              const SizedBox(height: 16),
              ...controller.data.map((v) {
                return GestureDetector(
                  onTap: () => controller.handleDetailPage(v),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 1,
                          spreadRadius: .1,
                          color: AppColor.black200,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(v.stuff!.stuffName!, style: textSemiBold),
                      subtitle: Text(
                        v.merk!,
                        style: textSemiBold.copyWith(
                          fontSize: 12,
                          color: AppColor.black200,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
