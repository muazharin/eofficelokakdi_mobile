import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/return_loan_opt_controller.dart';

class ReturnLoanOptView extends GetView<ReturnLoanOptController> {
  const ReturnLoanOptView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: GetBuilder<ReturnLoanOptController>(
          builder: (context) {
            return Text('Pilih ${controller.title}');
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBackButton(null),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<ReturnLoanOptController>(
        builder: (context) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          } else if (controller.data.isEmpty) {
            return Center(
              child: Text("Data tidak ditemukan", style: textRegular),
            );
          }
          return ListView(
            children: [
              ...controller.data.map((v) {
                return GestureDetector(
                  onTap: () => controller.handleBackButton(v),
                  child: ListTile(
                    title: Text(v.asset!.assetName!, style: textSemiBold),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "NUP : ${v.asset!.assetNup}\n${v.applicant!.applicantName!}",
                            overflow: TextOverflow.ellipsis,
                            style: textRegular,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat("dd MMM yyyy", "id").format(v.loanDate!),
                          style: textRegular.copyWith(
                            color: AppColor.success500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
