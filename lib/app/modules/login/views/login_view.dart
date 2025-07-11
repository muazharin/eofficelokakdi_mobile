import 'dart:ui';

import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:eoffice/app/data/utils/validators.dart';
import 'package:eoffice/app/data/widgets/button_default.dart';
import 'package:eoffice/app/data/widgets/input_password.dart';
import 'package:eoffice/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: SvgPicture.asset("assets/svg/img-auth-bg.svg"),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/komdigi.svg", height: 40),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.all(16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset.zero,
                              blurRadius: 0.0,
                              spreadRadius: .24,
                              blurStyle: BlurStyle.outer,
                            ),
                          ],
                        ),
                        child: Form(
                          key: controller.keyForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: textSemiBold.copyWith(fontSize: 24),
                              ),
                              SizedBox(height: 24),
                              Text("NIP", style: textRegular),
                              SizedBox(height: 8),
                              InputText(
                                hintText: "Masukkan NIP",
                                controller: controller.nip,
                                onChanged: (v) {},
                                validator: (v) => valNumber!(v!, "NIP"),
                              ),
                              SizedBox(height: 16),
                              Text("Password", style: textRegular),
                              SizedBox(height: 8),
                              InputPassword(
                                hintText: "Masukkan Password",
                                controller: controller.password,
                                onChanged: (v) {},
                                validator: (v) => valPassword!(v!, "Password"),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(),
                                  Text(
                                    "Forgot Password?",
                                    style: textSemiBold.copyWith(
                                      color: AppColor.black300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              ButtonDefault(
                                text: controller.isLoading
                                    ? "Loading..."
                                    : "Login",
                                color: AppColor.blue500,
                                onTap: controller.isLoading
                                    ? () {}
                                    : () => controller.handleLogin(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: textRegular,
                      children: [
                        TextSpan(text: "Copyrights "),
                        WidgetSpan(
                          child: Icon(Icons.copyright_outlined, size: 16),
                        ),
                        TextSpan(
                          text: " Loka Monitor SFR Kendari",
                          style: textSemiBold.copyWith(color: AppColor.blue500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
