import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/input_date.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('Edit Profil', style: textSemiBold.copyWith(fontSize: 20)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<ProfileEditController>(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                Row(
                  children: [
                    Text("NIP", style: textSemiBold),
                    const SizedBox(width: 8),
                    Icon(Icons.info_outline_rounded),
                  ],
                ),
                const SizedBox(height: 8),
                InputText(
                  hintText: "NIP",
                  controller: controller.nip,
                  onChanged: (v) {},
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("Name", style: textSemiBold),
                    const SizedBox(width: 8),
                    Icon(Icons.info_outline_rounded),
                  ],
                ),
                const SizedBox(height: 8),
                InputText(
                  hintText: "Name",
                  controller: controller.name,
                  onChanged: (v) {},
                  readOnly: true,
                ),
                const SizedBox(height: 8),
                Form(
                  key: controller.keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email", style: textSemiBold),
                      const SizedBox(height: 8),
                      InputText(
                        hintText: "Email",
                        controller: controller.email,
                        onChanged: (v) {},
                      ),
                      const SizedBox(height: 8),
                      Text("Phone", style: textSemiBold),
                      const SizedBox(height: 8),
                      InputText(
                        hintText: "Phone",
                        controller: controller.phone,
                        onChanged: (v) {},
                      ),
                      const SizedBox(height: 8),
                      Text("Tgl. Lahir", style: textSemiBold),
                      const SizedBox(height: 8),
                      InputDate(
                        hintText: "Tgl. Lahir",
                        controller: controller.birth,
                        isBirthDate: true,
                        onChanged: (v) {},
                        onTap: (v) => controller.handleSelectDate(v!),
                      ),
                      const SizedBox(height: 8),
                      Text("Alamat", style: textSemiBold),
                      const SizedBox(height: 8),
                      InputText(
                        hintText: "Alamat",
                        controller: controller.address,
                        onChanged: (v) {},
                        minLines: 4,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 16),
                      ButtonDefault(
                        text: controller.isLoading ? "Mengupdate..." : "Simpan",
                        color: AppColor.blue500,
                        onTap: controller.isLoading
                            ? () {}
                            : () => controller.handleSubmit(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text("Catatan:", style: textSemiBold),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.info_outline_rounded),
                    const SizedBox(width: 8),
                    Text("Read-only", style: textRegular),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
