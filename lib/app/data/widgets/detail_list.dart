import 'package:eoffice/app/data/themes/typography.dart';
import 'package:flutter/material.dart';

class DetailList extends StatelessWidget {
  const DetailList({super.key, this.name, this.value});
  final String? name;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(name ?? "", style: textRegular)),
        const SizedBox(width: 8),
        Text(":", style: textRegular),
        const SizedBox(width: 8),
        Expanded(flex: 3, child: Text(value ?? "", style: textRegular)),
      ],
    );
  }
}
