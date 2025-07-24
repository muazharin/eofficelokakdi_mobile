import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

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
                                title: Text(v.merk!, style: textSemiBold),
                                subtitle: Text(
                                  v.stuff!.stuffName!,
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        onPressed: () => controller.handleAddButton(),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
