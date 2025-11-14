import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          InkWell(
            onTap: () => controller.handleFilterBtn(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GetBuilder<AssetController>(
                builder: (context) {
                  return Badge(
                    isLabelVisible: controller.isVisibleBadge,
                    backgroundColor: AppColor.success700,
                    label: Text(
                      "${controller.sumVisibleBadge}",
                      style: textRegular.copyWith(color: Colors.white),
                    ),
                    child: Icon(Icons.tune),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          GetBuilder<AssetController>(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: InputText(
                  hintText: "Masukkan Nama/Merk Asset/Kode Barang",
                  borderRadius: 12,
                  controller: controller.searchController,
                  suffixIcon: Icon(Icons.search_rounded),
                  onChanged: (v) => controller.handleSearch(v),
                ),
              );
            },
          ),
          Expanded(
            child: GetBuilder<AssetController>(
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
                return LazyLoadScrollView(
                  onEndOfPage: () => controller.handleLoadMore(),
                  child: RefreshIndicator(
                    onRefresh: () async => controller.getAllData(),
                    child: ListView(
                      children: [
                        const SizedBox(height: 16),
                        ...controller.data.asMap().entries.map((v) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                              child: GestureDetector(
                                onTap: () =>
                                    controller.handleDetailPage(v.value),
                                child: Slidable(
                                  controller: v.key == 0
                                      ? controller.slideController
                                      : null,
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (x) => controller
                                            .handleDeleteBtn(v.value.assetId),
                                        backgroundColor: AppColor.error600,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_outline_rounded,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      v.value.stuff!.stuffName!,
                                      style: textSemiBold,
                                    ),
                                    subtitle: Text(
                                      v.value.merk!,
                                      style: textSemiBold.copyWith(
                                        fontSize: 12,
                                        color: AppColor.black200,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        v.value.isShowNote == "Yes"
                                            ? Icon(
                                                Icons.circle_rounded,
                                                size: 14,
                                                color: AppColor.success500,
                                              )
                                            : const SizedBox(),
                                        const SizedBox(width: 8),
                                        Icon(Icons.arrow_forward_ios_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GetBuilder<AssetController>(
        builder: (context) {
          if (!controller.isAdmin) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () => controller.handleScanner(),
              child: Icon(Icons.qr_code_scanner_rounded),
            );
          }
          return SpeedDial(
            backgroundColor: Colors.white,
            icon: Icons.menu_rounded,
            activeIcon: Icons.close,
            spacing: 3,
            spaceBetweenChildren: 4,
            openCloseDial: controller.isDialOpen,
            childPadding: const EdgeInsets.all(5),
            childrenButtonSize: Size.fromRadius(32),
            animationCurve: Curves.elasticInOut,
            children: [
              // SpeedDialChild(
              //   child: Icon(Icons.add_rounded),
              //   onTap: () => controller.handleAddButton(),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(32),
              //   ),
              // ),
              SpeedDialChild(
                child: Icon(Icons.qr_code_scanner_rounded),
                onTap: () => controller.handleScanner(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              SpeedDialChild(
                child: Icon(Icons.file_download_outlined),
                onTap: () => controller.handleDownloadFile(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
