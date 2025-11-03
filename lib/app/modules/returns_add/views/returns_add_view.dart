import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/input_select.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/returns_add_controller.dart';

class ReturnsAddView extends GetView<ReturnsAddController> {
  const ReturnsAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GetBuilder<ReturnsAddController>(
          builder: (context) {
            return Text(
              '${controller.title} Pengembalian',
              style: textSemiBold.copyWith(fontSize: 20),
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<ReturnsAddController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  InputSelect(
                    hintText: "Pilih Peminjaman",
                    onTap: () => controller.handleSelectOpt({
                      "title": "Pilih Peminjaman",
                      "path":
                          "${AppVariable.returnsMyDataLoan}?user_id=${controller.userData["user_id"]}",
                    }),
                    controller: controller.loanSelect,
                    validator: (v) => valString!(v, "Peminjaman"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
