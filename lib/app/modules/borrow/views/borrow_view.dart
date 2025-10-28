import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/borrow_controller.dart';

class BorrowView extends GetView<BorrowController> {
  const BorrowView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Peminjaman', style: textSemiBold.copyWith(fontSize: 20)),
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
    );
  }
}
