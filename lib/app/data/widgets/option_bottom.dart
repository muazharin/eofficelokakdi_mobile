import 'package:eoffice/app/data/models/menu.dart';
import 'package:eoffice/app/data/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showOptionsBottomSheet({required List<MenuModel> menu}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Wrap(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(top: 8, bottom: 32),
                decoration: BoxDecoration(
                  color: AppColor.black200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          ...menu.map((v) {
            return ListTile(
              leading: Icon(v.iconData),
              title: Text(v.name ?? ""),
              onTap: v.onTap,
            );
          }),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
