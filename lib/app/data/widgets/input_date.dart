import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class InputDate extends StatefulWidget {
  const InputDate({
    super.key,
    this.controller,
    this.onTap,
    this.validator,
    this.onChanged,
    this.hintText,
    this.isBirthDate = false,
  });
  final TextEditingController? controller;
  final void Function(DateTime? v)? onTap;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool? isBirthDate;
  final void Function(String)? onChanged;

  @override
  State<InputDate> createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      onChanged: widget.onChanged,
      onTap: widget.onTap != null
          ? () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: widget.isBirthDate!
                    ? DateTime(1900, 1, 1)
                    : DateTime.now(),
                lastDate: widget.isBirthDate! ? DateTime.now() : DateTime(2100),
              );
              if (picked != null) {
                widget.onTap!(picked);
              }
            }
          : () {},
      readOnly: true,
      validator: widget.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Icon(Icons.calendar_month_rounded, color: AppColor.black400),
        ),
        hintText: widget.hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.black400),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.error600),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error600),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black100),
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
