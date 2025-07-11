import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/asset_detail_controller.dart';

class AssetDetailView extends GetView<AssetDetailController> {
  const AssetDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Asset', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.rootDelegate.popRoute(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<AssetDetailController>(
        builder: (context) {
          return const Center(
            child: Text(
              'AssetDetailView is working',
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
