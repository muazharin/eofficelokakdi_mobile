import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/asset_filter_controller.dart';

class AssetFilterView extends GetView<AssetFilterController> {
  const AssetFilterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<AssetFilterController>(
          builder: (context) {
            return Text(
              'Filter ${controller.title}',
              style: textSemiBold.copyWith(fontSize: 20),
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackButton(),
          child: Icon(Icons.clear_rounded),
        ),
        actions: [
          InkWell(
            onTap: () => controller.handleClearFilter(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Hapus", style: textRegular),
            ),
          ),
        ],
      ),
      body: GetBuilder<AssetFilterController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(
              child: Text("Terjadi kesalahan!", style: textRegular),
            );
          } else if (controller.listBmns.isEmpty ||
              controller.listStuffs.isEmpty) {
            return Center(
              child: Text("Data tidak ditemukan", style: textRegular),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text("BMN", style: textSemiBold),
                    const SizedBox(width: 8),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                ...controller.listBmns.map((v) {
                  return GestureDetector(
                    onTap: () => controller.handleSelectBmn(v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            v.id == controller.selectedBmn.id
                                ? Icon(
                                    Icons.circle_rounded,
                                    color: AppColor.success600,
                                  )
                                : Icon(Icons.circle_outlined),
                            const SizedBox(width: 8),
                            Text(v.name!, style: textRegular),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }),

                // const SizedBox(height: 16),
                // Row(
                //   children: [
                //     Text("Barang", style: textSemiBold),
                //     const SizedBox(width: 8),
                //     Expanded(child: Divider()),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // Wrap(
                //   children: [
                //     ...controller.listStuffs.map((v) {
                //       return InkWell(
                //         onTap: () => controller.handleSelectStuff(v),
                //         child: SizedBox(
                //           width: (Get.width / 2) - 32,
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               v.id == controller.selectedStuff.id
                //                   ? Icon(
                //                       Icons.circle_rounded,
                //                       color: AppColor.success600,
                //                     )
                //                   : Icon(Icons.circle_outlined),
                //               const SizedBox(width: 8),
                //               Expanded(
                //                 child: Text(v.name!, style: textRegular),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     }),
                //   ],
                // ),
                // const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
