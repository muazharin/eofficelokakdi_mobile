import 'package:eoffice/app/data/models/chart_data.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: unused_import
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller.drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColor.blue500, AppColor.blue200],
          ),
        ),
      ),
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 0.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // ListTile(
              //   onTap: () {},
              //   leading: Icon(Icons.home),
              //   title: Text('Home'),
              // ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dashboard",
                      style: textSemiBold.copyWith(fontSize: 20),
                    ),
                    InkWell(
                      onTap: () => controller.handleDrawer(),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: .1,
                              color: AppColor.black200,
                            ),
                          ],
                        ),
                        child: Icon(Icons.menu_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: .1,
                              color: AppColor.black200,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: SizedBox(
                                    height: 150,
                                    width: Get.width,
                                    child: Image.asset(
                                      "assets/jpg/office.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    108,
                                    0,
                                    16,
                                    16,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Muazharin Alfan",
                                        style: textSemiBold.copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "199611072025041004",
                                        style: textRegular.copyWith(
                                          color: AppColor.black500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 108,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image.asset(
                                    "assets/jpg/alfan.jpg",
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: GridView.count(
                        crossAxisCount: 5,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 9 / 15,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: [
                          ...controller.menus.map((v) {
                            return GestureDetector(
                              onTap: v.onTap,
                              child: Container(
                                padding: const EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 1,
                                      spreadRadius: .1,
                                      color: AppColor.black200,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: v.bgColor,
                                      child: Image.asset(
                                        v.icon!,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                        color: v.txColor,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      v.name!,
                                      style: textSemiBold.copyWith(
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            "Summary",
                            style: textSemiBold.copyWith(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Expanded(child: Divider(color: AppColor.black100)),
                          SizedBox(width: 8),
                          Text(
                            DateFormat("dd MMM yyyy").format(DateTime.now()),
                            style: textSemiBold,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 1,
                              spreadRadius: .1,
                              color: AppColor.black200,
                            ),
                          ],
                        ),
                        child: GetBuilder<HomeController>(
                          builder: (context) {
                            return Row(
                              children: [
                                Expanded(
                                  child: SfCircularChart(
                                    title: ChartTitle(
                                      text: "Rata-Rata Kondisi Asset",
                                      textStyle: textSemiBold.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                    margin: const EdgeInsets.fromLTRB(
                                      0,
                                      8,
                                      0,
                                      0,
                                    ),
                                    tooltipBehavior: controller.tooltip,
                                    series: <CircularSeries>[
                                      // Renders doughnut chart
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: controller.dataChart,
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          margin: const EdgeInsets.only(
                                            right: 2,
                                          ),
                                          color: Color.fromRGBO(0, 131, 136, 1),
                                        ),
                                        Text(
                                          "Baik",
                                          style: textRegular.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          margin: const EdgeInsets.only(
                                            right: 2,
                                          ),
                                          color: Color.fromRGBO(
                                            255,
                                            189,
                                            57,
                                            1,
                                          ),
                                        ),
                                        Text(
                                          "Rusak Ringan",
                                          style: textRegular.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 12,
                                          width: 12,
                                          margin: const EdgeInsets.only(
                                            right: 2,
                                          ),
                                          color: Color.fromRGBO(228, 0, 124, 1),
                                        ),
                                        Text(
                                          "Rusak Berat",
                                          style: textRegular.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(16),
                    //       boxShadow: [
                    //         BoxShadow(
                    //           offset: Offset(0, 0),
                    //           blurRadius: 1,
                    //           spreadRadius: .1,
                    //           color: AppColor.black200,
                    //         ),
                    //       ],
                    //     ),
                    //     child: SfCartesianChart(
                    //       tooltipBehavior: controller.tooltip,
                    //       // Initialize category axis
                    //       primaryXAxis: CategoryAxis(),
                    //       series: <CartesianSeries>[
                    //         // Initialize line series
                    //         LineSeries<ChartData, String>(
                    //           dataSource: [
                    //             // Bind data source
                    //             ChartData('Jan', 35, AppColor.blue500),
                    //             ChartData('Feb', 28, AppColor.success500),
                    //             ChartData('Mar', 34, AppColor.yellow500),
                    //             ChartData('Apr', 32, AppColor.error500),
                    //           ],
                    //           xValueMapper: (ChartData data, _) => data.x,
                    //           yValueMapper: (ChartData data, _) => data.y,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
