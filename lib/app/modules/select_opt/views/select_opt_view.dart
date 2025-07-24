import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/select_opt_controller.dart';

class SelectOptView extends GetView<SelectOptController> {
  const SelectOptView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GetBuilder<SelectOptController>(
          builder: (context) {
            return Text('Pilih ${controller.title}');
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackButton(null),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<SelectOptController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          } else if (controller.data.isEmpty) {
            return Center(
              child: Text("Data tidak ditemukan", style: textRegular),
            );
          }
          return ListView(
            children: [
              ...controller.data.map((v) {
                return GestureDetector(
                  onTap: () => controller.handleBackButton(v),
                  child: ListTile(title: Text(v.name!, style: textSemiBold)),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
