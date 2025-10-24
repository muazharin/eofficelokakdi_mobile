import 'package:cached_network_image/cached_network_image.dart';
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
              ListTile(
                onTap: () => controller.handleProfileBtn(),
                leading: Icon(Icons.person_outline_rounded),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: () => controller.handleAboutBtn(),
                leading: Icon(Icons.info_outline_rounded),
                title: Text('Tentang'),
              ),
              Divider(color: Colors.white),
              ListTile(
                onTap: () => controller.handleLogout(),
                leading: Icon(Icons.logout_rounded),
                title: Text('Keluar'),
              ),
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
                                GetBuilder<HomeController>(
                                  builder: (context) {
                                    return Padding(
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
                                            "${controller.userData['user_name']}",
                                            style: textSemiBold.copyWith(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            controller.userData['user_nip'] ??
                                                controller
                                                    .userData['user_email'] ??
                                                "",
                                            style: textRegular.copyWith(
                                              color: AppColor.black500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Positioned(
                              top: 108,
                              left: 16,
                              child: GetBuilder<HomeController>(
                                builder: (context) {
                                  return SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Stack(
                                      children: [
                                        controller.userData['user_photo']
                                                .toString()
                                                .isNotEmpty
                                            ? GestureDetector(
                                                onTap: () =>
                                                    controller.handleShowPhoto([
                                                      "${controller.userData['user_photo']}",
                                                    ]),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        100,
                                                      ),
                                                  child: CachedNetworkImage(
                                                    height: 160,
                                                    width: 160,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        "${controller.userData['user_photo']}",
                                                    placeholder: (context, url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget:
                                                        (
                                                          context,
                                                          url,
                                                          error,
                                                        ) => Container(
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColor
                                                                  .black200,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  100,
                                                                ),
                                                          ),
                                                          child: Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                padding: const EdgeInsets.all(
                                                  2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: Image.asset(
                                                    "assets/png/user.png",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: GridView.count(
                        crossAxisCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 1,
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
                                      color: v.txColor!.withAlpha(80),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: v.bgColor,
                                      child: Image.asset(
                                        v.icon!,
                                        width: 28,
                                        height: 28,
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
                        // height: 200,
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
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SfCartesianChart(
                                  title: ChartTitle(
                                    text: "Data Tahun Perolehan Barang",
                                    textStyle: textSemiBold.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  primaryXAxis: CategoryAxis(),
                                  primaryYAxis: NumericAxis(
                                    minimum: 0,
                                    maximum: 120,
                                    interval: 10,
                                  ),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                  ),
                                  series:
                                      <CartesianSeries<ChartDataModel, String>>[
                                        ColumnSeries<ChartDataModel, String>(
                                          dataSource: controller.dataChart,
                                          pointColorMapper:
                                              (ChartDataModel data, _) =>
                                                  data.color,
                                          xValueMapper:
                                              (ChartDataModel data, _) =>
                                                  data.chartName,
                                          yValueMapper:
                                              (ChartDataModel data, _) =>
                                                  data.chartTotal,
                                          // dataLabelSettings: DataLabelSettings(
                                          //   isVisible: true,
                                          //   textStyle: textRegular,
                                          // ),
                                        ),
                                      ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
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
