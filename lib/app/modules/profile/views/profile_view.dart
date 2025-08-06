import 'package:cached_network_image/cached_network_image.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/input_password.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Profil', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          InkWell(
            onTap: () => controller.handleEditBtn(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(Icons.edit_outlined),
            ),
          ),
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => controller.handleShowPhoto([
                            controller.data.userPhoto!,
                          ]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              height: 160,
                              width: 160,
                              fit: BoxFit.cover,
                              imageUrl: controller.data.userPhoto!,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.black200),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => controller.handleUpdatePhoto(),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: AppColor.black200),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: AppColor.blue500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("NIP", style: textSemiBold),
                      Text("${controller.data.userNip}", style: textRegular),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nama", style: textSemiBold),
                      Text(controller.data.userName ?? "", style: textRegular),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(child: Divider()),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => controller.setShowMore(),
                        child: Icon(
                          controller.isShowMore
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.isShowMore,
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email", style: textSemiBold),
                            Text(
                              controller.data.userEmail ?? "",
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone", style: textSemiBold),
                            Text(
                              controller.data.userPhone ?? "",
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tgl. Lahir", style: textSemiBold),
                            Text(
                              DateFormat(
                                "dd MMM yyyy",
                              ).format(controller.data.userTglLahir!),
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Jenis Kelamin", style: textSemiBold),
                            Text(
                              controller.data.userGender ?? "",
                              style: textRegular,
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Alamat", style: textSemiBold),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                controller.data.userAddress ?? "",
                                textAlign: TextAlign.end,
                                style: textRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.keyForm,
                    child: Column(
                      children: [
                        InputPassword(
                          hintText: "Masukkan Password Baru",
                          controller: controller.password,
                          onChanged: (v) {},
                          validator: (v) => valPassword!(v, "Password Baru"),
                        ),
                        const SizedBox(height: 8),
                        InputPassword(
                          hintText: "Masukkan Konfirmasi Password Baru",
                          controller: controller.passwordC,
                          onChanged: (v) {},
                          validator: (v) => valCPassword!(
                            v,
                            "Konfirmasi Password Baru",
                            controller.password.text,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ButtonDefault(
                          text: "Simpan",
                          color: AppColor.blue500,
                          onTap: () => controller.handleSubmit(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
