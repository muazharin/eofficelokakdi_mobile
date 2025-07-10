import 'package:eoffice/app/data/themes/colors.dart';
import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.validator,
    this.maxLines,
    this.minLines,
    this.borderRadius = 4,
  });
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final int? maxLines;
  final int? minLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<InputPassword> createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool isShow = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: textRegular,
      obscureText: isShow,
      onChanged: widget.onChanged,
      validator: widget.validator,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines ?? 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: widget.prefixIcon,
        prefixIconColor: AppColor.black100,
        suffixIcon: InkWell(
          onTap: () => setState(() => isShow = !isShow),
          child: isShow
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
        hintText: widget.hintText ?? '',
        hintStyle: textRegular.copyWith(color: AppColor.black400),
        errorMaxLines: 4,
        errorStyle: textRegular.copyWith(color: AppColor.error600),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.error600),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black400),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.black100),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
      ),
    );
  }
}
