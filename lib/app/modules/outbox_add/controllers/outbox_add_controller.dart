import 'dart:convert';
import 'dart:io';

import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OutboxAddController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var title = "Tambah";
  var outboxSerialNo = 0;
  var outboxNo = TextEditingController();
  var outboxFrom = TextEditingController();
  var outboxTo = TextEditingController();
  var outboxAbout = TextEditingController();
  var outboxType = TextEditingController();
  var outboxDate = TextEditingController();
  var outboxDateFormat = DateTime.now();
  var key = GlobalKey<FormState>();
  var key2 = GlobalKey<FormState>();
  late TabController tabController;
  File? file;

  @override
  void onInit() {
    super.onInit();
    getSerialNo();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      onTabChanged(tabController.index);
    });
  }

  void getSerialNo() async {
    try {
      final response = await Api().getWithToken(path: AppVariable.serialNo);
      var result = jsonDecode(response.toString());
      if (result['status']) {
        outboxSerialNo = result['data'];
        update();
      }
    } catch (_) {}
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) {
    print("Tab changed to: $index");
    // Put your logic here
  }

  void handleBackBtn() {
    Get.back();
  }

  void handleSelectDate(DateTime v) {
    outboxDate.text = DateFormat("dd MMMM yyyy").format(v);
    outboxDateFormat = v;
    update();
  }

  void handleAddFileBtn() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );

    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path ?? "");
      update();
    }

    return;
  }

  void handleRemoveFileBtn() {
    file = null;
    update();
  }

  void handleSubmit() {
    FocusScope.of(Get.context!).unfocus();
    if (key.currentState!.validate()) {}
  }
}
