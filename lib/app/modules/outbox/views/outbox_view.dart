import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/outbox_controller.dart';

class OutboxView extends GetView<OutboxController> {
  const OutboxView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OutboxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OutboxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
