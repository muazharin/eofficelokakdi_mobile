import 'dart:ui';

import 'package:eoffice/app/data/models/chart_data.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeController extends GetxController {
  var menus = <MenuModel>[];
  var dataChart = <ChartData>[];
  var tooltip = TooltipBehavior(enable: true);
  var drawerController = AdvancedDrawerController();

  @override
  void onInit() {
    menus = [
      MenuModel(
        id: 1,
        name: "Asset",
        icon: "assets/png/cube.png",
        bgColor: Color(0xfffef5e8),
        txColor: Color(0xfffda027),
        onTap: () => Get.rootDelegate.toNamed(Routes.ASSET),
      ),
      MenuModel(
        id: 2,
        name: "Surat Masuk",
        icon: "assets/png/envelope-download.png",
        bgColor: Color(0xffe9f6fe),
        txColor: Color(0xff1d9fff),
        onTap: () {},
      ),
      MenuModel(
        id: 3,
        name: "Surat Keluar",
        icon: "assets/png/envelope-upload.png",
        bgColor: Color(0xfff1fadd),
        txColor: Color(0xffa5df29),
        onTap: () {},
      ),
      MenuModel(
        id: 4,
        name: "SPT",
        icon: "assets/png/document-signed.png",
        bgColor: Color(0xfffdeef5),
        txColor: Color(0xfffb2e95),
        onTap: () {},
      ),
      MenuModel(
        id: 5,
        name: "Agenda",
        icon: "assets/png/calendar.png",
        bgColor: Color(0xfffdedf0),
        txColor: Color(0xfffd3661),
        onTap: () {},
      ),
    ];
    update();
    getChartData();
    super.onInit();
  }

  void getChartData() {
    dataChart = [
      ChartData('Baik', 50, Color.fromRGBO(0, 131, 136, 1)),
      ChartData('Rusak Ringan', 15, Color.fromRGBO(255, 189, 57, 1)),
      ChartData('Rusak Berat', 8, Color.fromRGBO(228, 0, 124, 1)),
    ];
    update();
  }

  void handleDrawer() {
    print("handleDrawer");
    drawerController.showDrawer();
  }
}
