import 'dart:ui';

import 'package:eoffice/app/data/models/chart_data.dart';
import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/models/tags.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeController extends GetxController {
  var tag = TagsModel();
  var tags = <TagsModel>[];
  var menus = <MenuModel>[];
  var dataChart = <ChartData>[];
  var tooltip = TooltipBehavior(enable: true);

  @override
  void onInit() {
    tags = [
      TagsModel(id: 1, name: "Assets", onTap: () {}),
      TagsModel(id: 2, name: "Surat Masuk", onTap: () {}),
      TagsModel(id: 3, name: "Surat Keluar", onTap: () {}),
      TagsModel(id: 4, name: "SPT", onTap: () {}),
      TagsModel(id: 5, name: "Agenda", onTap: () {}),
    ];
    tag = tags[0];
    menus = [
      MenuModel(
        id: 1,
        name: "Assets",
        icon: "assets/png/cube.png",
        bgColor: Color(0xfffef5e8),
        txColor: Color(0xfffda027),
        onTap: () {},
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

  void handleSelectTag(TagsModel? v) {
    tag = v!;
    update();
  }

  void getChartData() {
    dataChart = [
      ChartData('Baik', 50, Color.fromRGBO(0, 131, 136, 1)),
      ChartData('Rusak Ringan', 15, Color.fromRGBO(255, 189, 57, 1)),
      ChartData('Rusak Berat', 8, Color.fromRGBO(228, 0, 124, 1)),
    ];
    update();
  }
}
