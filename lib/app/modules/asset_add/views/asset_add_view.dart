import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/asset_add_controller.dart';

class AssetAddView extends GetView<AssetAddController> {
  const AssetAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssetAddView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AssetAddView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
