import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/info_tile.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Tentang Aplikasi",
          style: textSemiBold.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackBtn(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<AboutController>(
        builder: (context) {
          return SafeArea(
            child: Container(
              // margin: const EdgeInsets.all(16),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(16),
              //     boxShadow: const [
              //       BoxShadow(
              //         offset: Offset(0, 4),
              //         blurRadius: 16,
              //         spreadRadius: 1,
              //         color: AppColor.black100,
              //       ),
              //     ],
              //   ),
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    children: [
                      InfoTile(
                        title: 'App name',
                        subtitle: controller.packageInfo.appName,
                      ),
                      InfoTile(
                        title: 'Package name',
                        subtitle: controller.packageInfo.packageName,
                      ),
                      InfoTile(
                        title: 'App version',
                        subtitle: controller.packageInfo.version,
                      ),
                      InfoTile(
                        title: 'Build number',
                        subtitle: controller.packageInfo.buildNumber,
                      ),
                      InfoTile(
                        title: 'Build signature',
                        subtitle: controller.packageInfo.buildSignature,
                      ),
                      InfoTile(
                        title: 'Installer store',
                        subtitle:
                            controller.packageInfo.installerStore ??
                            'not available',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
