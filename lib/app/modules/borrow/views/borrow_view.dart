import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/borrow_controller.dart';

class BorrowView extends GetView<BorrowController> {
  const BorrowView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Export to PDF')),
      body: GetBuilder<BorrowController>(
        builder: (context) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () => controller.onSubmit(),
                child: Text('Export to PDF'),
              ),
            ],
          );
        },
      ),
    );
  }
}
