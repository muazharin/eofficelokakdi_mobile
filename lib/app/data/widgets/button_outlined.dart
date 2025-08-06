import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class ButtonOutlined extends StatelessWidget {
  const ButtonOutlined({
    super.key,
    required this.text,
    this.textSize,
    this.color,
    this.radius,
    required this.onTap,
    required this.borderColor,
    this.leading,
    this.trailing,
  });
  final String? text;
  final double? textSize;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final void Function()? onTap;
  final Widget? leading;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(radius ?? 12),
          border: Border.all(color: borderColor ?? AppColor.yellow500),
        ),
        child: Row(
          children: [
            leading ?? const SizedBox(),
            Expanded(
              child: Center(
                child: Text(
                  text!,
                  style: textBold.copyWith(
                    color: borderColor,
                    fontSize: textSize ?? 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
