import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
// import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/button_outlined.dart';
import 'package:eoffice/app/data/widgets/input_date.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outbox_add_controller.dart';

class OutboxAddView extends GetView<OutboxAddController> {
  const OutboxAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${controller.title} Surat Keluar',
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackBtn(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColor.blue200,
              ),
              child: GetBuilder<OutboxAddController>(
                builder: (context) {
                  return TabBar(
                    controller: controller.tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColor.blue500,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          "Normal",
                          style: textSemiBold.copyWith(color: Colors.white),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Custom",
                          style: textSemiBold.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GetBuilder<OutboxAddController>(
              builder: (context) {
                return TabBarView(
                  controller: controller.tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: controller.key,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              InputText(
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColor.black200,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(4),
                                    ),
                                  ),
                                  child: Text(
                                    "${controller.outboxSerialNo}/Lokmon.74/",
                                    style: textSemiBold.copyWith(
                                      fontSize: 16,
                                      color: AppColor.black400,
                                    ),
                                  ),
                                ),
                                hintText: "No. Surat",
                                controller: controller.outboxNo,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "No. Surat"),
                              ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Dari",
                                controller: controller.outboxFrom,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Dari"),
                              ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Kepada",
                                controller: controller.outboxTo,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Kepada"),
                              ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Perihal",
                                controller: controller.outboxAbout,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Perihal"),
                              ),
                              const SizedBox(height: 16),
                              InputDate(
                                hintText: "Tanggal Surat",
                                controller: controller.outboxDate,
                                onChanged: (v) {},
                                isBirthDate: true,
                                validator: (v) =>
                                    valString!(v, "Tanggal Surat"),
                                onTap: (v) => controller.handleSelectDate(v!),
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () => controller.handleAddFileBtn(),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.black100,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: controller.file == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.picture_as_pdf_rounded,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Tambahkan sekarang",
                                                style: textRegular,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListTile(
                                          leading: Icon(
                                            Icons.picture_as_pdf_rounded,
                                          ),
                                          title: Text(
                                            controller.file!.path
                                                .split("/")
                                                .last,
                                            overflow: TextOverflow.ellipsis,
                                            style: textRegular,
                                          ),
                                          trailing: InkWell(
                                            onTap: () => controller
                                                .handleRemoveFileBtn(),
                                            child: Icon(Icons.clear_rounded),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ButtonOutlined(
                                text: "Kirim",
                                borderColor: AppColor.blue500,
                                onTap: () => controller.handleSubmit(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: controller.key2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // const SizedBox(height: 16),
                              // InputText(
                              //   prefixIcon: Container(
                              //     padding: const EdgeInsets.all(12),
                              //     decoration: BoxDecoration(
                              //       color: AppColor.black200,
                              //       borderRadius: BorderRadius.horizontal(
                              //         left: Radius.circular(4),
                              //       ),
                              //     ),
                              //     child: Text(
                              //       "001/Lokmon.74/",
                              //       style: textSemiBold.copyWith(
                              //         fontSize: 16,
                              //         color: AppColor.black400,
                              //       ),
                              //     ),
                              //   ),
                              //   hintText: "No. Surat",
                              //   controller: controller.outboxNo,
                              //   onChanged: (v) {},
                              //   validator: (v) => valString!(v, "No. Surat"),
                              // ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Dari",
                                controller: controller.outboxFrom,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Dari"),
                              ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Kepada",
                                controller: controller.outboxTo,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Kepada"),
                              ),
                              const SizedBox(height: 16),
                              InputText(
                                hintText: "Perihal",
                                controller: controller.outboxAbout,
                                onChanged: (v) {},
                                validator: (v) => valString!(v, "Perihal"),
                              ),
                              const SizedBox(height: 16),
                              InputDate(
                                hintText: "Tanggal Surat",
                                controller: controller.outboxDate,
                                onChanged: (v) {},
                                isBirthDate: true,
                                validator: (v) =>
                                    valString!(v, "Tanggal Surat"),
                                onTap: (v) => controller.handleSelectDate(v!),
                              ),
                              const SizedBox(height: 16),
                              InkWell(
                                onTap: () => controller.handleAddFileBtn(),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.black100,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: controller.file == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.picture_as_pdf_rounded,
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Tambahkan sekarang",
                                                style: textRegular,
                                              ),
                                            ],
                                          ),
                                        )
                                      : ListTile(
                                          leading: Icon(
                                            Icons.picture_as_pdf_rounded,
                                          ),
                                          title: Text(
                                            controller.file!.path
                                                .split("/")
                                                .last,
                                            overflow: TextOverflow.ellipsis,
                                            style: textRegular,
                                          ),
                                          trailing: InkWell(
                                            onTap: () => controller
                                                .handleRemoveFileBtn(),
                                            child: Icon(Icons.clear_rounded),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ButtonOutlined(
                                text: "Kirim",
                                borderColor: AppColor.blue500,
                                onTap: () => controller.handleSubmit(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
