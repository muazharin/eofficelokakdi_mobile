import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:eoffice/app/data/models/chart_data.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/pop_up_option.dart';
// import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeController extends GetxController {
  var box = SecureStorageService();
  var menus = <MenuModel>[];
  var dataChart = <ChartDataModel>[];
  var tooltip = TooltipBehavior(enable: true);
  var userData = <String, dynamic>{};
  var drawerController = AdvancedDrawerController();
  Color getSolidRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(156) + 100, // red (100-255)
      random.nextInt(156) + 100, // green (100-255)
      random.nextInt(156) + 100, // blue (100-255)
    );
  }

  List<ChartDataModel> assignRandomColors(List<ChartDataModel> data) {
    return data.asMap().entries.map((item) {
      return ChartDataModel(
        chartId: item.key + 1,
        chartName: item.value.chartName,
        chartTotal: item.value.chartTotal,
        color: getSolidRandomColor(),
      );
    }).toList();
  }

  @override
  void onInit() {
    menus = [
      MenuModel(
        id: 1,
        name: "Asset",
        icon: "assets/png/cube.png",
        bgColor: Color(0xfffef5e8),
        txColor: Color(0xfffda027),
        onTap: () => Get.toNamed(Routes.ASSET),
      ),
      MenuModel(
        id: 6,
        name: "Peminjaman",
        icon: "assets/png/ballot.png",
        bgColor: Color(0xffefbbff),
        txColor: Color(0xffbe29ec),
        onTap: () => Get.toNamed(Routes.BORROW),
      ),
      MenuModel(
        id: 2,
        name: "Pengembalian",
        icon: "assets/png/returns.png",
        bgColor: Color(0xffe9f6fe),
        txColor: Color(0xff1d9fff),
        onTap: () => Get.toNamed(Routes.RETURNS),
      ),
      // MenuModel(
      //   id: 2,
      //   name: "Surat Masuk",
      //   icon: "assets/png/envelope-download.png",
      //   bgColor: Color(0xffe9f6fe),
      //   txColor: Color(0xff1d9fff),
      //   onTap: () => snackbarWarning(message: "Sedang proses development"),
      // ),
      // MenuModel(
      //   id: 3,
      //   name: "Surat Keluar",
      //   icon: "assets/png/envelope-upload.png",
      //   bgColor: Color(0xfff1fadd),
      //   txColor: Color(0xffa5df29),
      //   // onTap: () => Get.toNamed(Routes.OUTBOX),
      //   onTap: () => snackbarWarning(message: "Sedang proses development"),
      // ),
      // MenuModel(
      //   id: 4,
      //   name: "SPT",
      //   icon: "assets/png/document-signed.png",
      //   bgColor: Color(0xfffdeef5),
      //   txColor: Color(0xfffb2e95),
      //   onTap: () => snackbarWarning(message: "Sedang proses development"),
      // ),
      // MenuModel(
      //   id: 5,
      //   name: "Agenda",
      //   icon: "assets/png/calendar.png",
      //   bgColor: Color(0xfffdedf0),
      //   txColor: Color(0xfffd3661),
      //   onTap: () => snackbarWarning(message: "Sedang proses development"),
      // ),
    ];
    update();
    getDataUser();
    getChartData();
    super.onInit();
  }

  void getDataUser() async {
    userData['user_photo'] = 'https://picsum.photos/200/300';
    userData = JwtDecoder.decode((await box.getData("token"))!);
    update();
  }

  void getChartData() async {
    try {
      final response = await Api().getWithToken(path: AppVariable.assetChart);
      var result = jsonDecode(response.toString());
      if (result['status']) {
        var list = (result['data'] as List)
            .map((v) => ChartDataModel.fromJson(v))
            .toList();
        dataChart = assignRandomColors(list);
      } else {
        dataChart = [];
      }
    } catch (e) {
      dataChart = [];
    } finally {
      update();
    }
  }

  void handleDrawer() {
    drawerController.showDrawer();
  }

  void handleLogout() {
    drawerController.hideDrawer();
    Get.dialog(
      PopUpOption(
        title: "Keluar",
        detail: "Anda yakin ingin keluar?",
        onTap: () => doLogout(),
      ),
    );
  }

  void handleProfileBtn() {
    drawerController.hideDrawer();
    Get.toNamed(Routes.PROFILE)!.then((_) => getDataUser());
  }

  void handleAboutBtn() {
    drawerController.hideDrawer();
    Get.toNamed(Routes.ABOUT);
  }

  void handleShowPhoto(List<String> img) {
    Get.toNamed(Routes.PHOTO, arguments: {"images": img});
  }

  void doLogout() {
    box.clear();
    Get.offAllNamed(Routes.LOGIN);
  }
}
