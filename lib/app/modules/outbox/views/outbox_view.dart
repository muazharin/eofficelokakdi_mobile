import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outbox_controller.dart';

class OutboxView extends GetView<OutboxController> {
  const OutboxView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Surat Keluar', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackBtn(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          InkWell(
            onTap: () => controller.handleAddBtn(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.add_rounded),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('OutboxView is working', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
