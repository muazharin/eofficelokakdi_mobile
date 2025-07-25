import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({super.key, this.txBtn, this.onTap});
  final String? txBtn;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: AppColor.blue200,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: AppColor.blue400,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColor.blue600,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    txBtn!,
                    style: textSemiBold.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
