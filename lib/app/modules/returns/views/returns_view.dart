import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../controllers/returns_controller.dart';

class ReturnsView extends GetView<ReturnsController> {
  const ReturnsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Pengembalian', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () => controller.handleAdd(),
        child: Icon(Icons.add),
      ),
      body: GetBuilder<ReturnsController>(
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
              onRefresh: () async => controller.getData(),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  ...controller.data.map((vs) {
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: Divider(color: AppColor.black100)),
                            const SizedBox(width: 8),
                            Text(
                              vs.name!,
                              style: textRegular.copyWith(
                                color: AppColor.black500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(child: Divider(color: AppColor.black100)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...vs.riwayat!.map((v) {
                          return GestureDetector(
                            onTap: () =>
                                controller.handleDetail(v.assetReturnId!),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black100,
                                    offset: Offset(0, 3),
                                    blurRadius: .16,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  v.asset!.assetName!,
                                  style: textSemiBold,
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "NUP : ${v.asset!.assetNup}\n${v.applicant!.applicantName!}",
                                        overflow: TextOverflow.ellipsis,
                                        style: textRegular,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      DateFormat(
                                        "dd MMM yyyy",
                                        "id",
                                      ).format(v.returnDate!),
                                      style: textRegular.copyWith(
                                        color: AppColor.success500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
