import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({super.key, this.title, this.subtitle});
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title!, style: textSemiBold.copyWith(fontSize: 14)),
      subtitle: Text(
        subtitle!.isEmpty ? 'Not set' : subtitle!,
        style: textRegular.copyWith(fontSize: 12),
      ),
    );
  }
}
