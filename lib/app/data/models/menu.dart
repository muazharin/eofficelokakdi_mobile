import 'package:flutter/material.dart';

class MenuModel {
  int? id;
  String? name;
  String? icon;
  IconData? iconData;
  Color? bgColor;
  Color? txColor;
  void Function()? onTap;

  MenuModel({
    this.id,
    this.name,
    this.icon,
    this.iconData,
    this.onTap,
    this.bgColor,
    this.txColor,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    iconData: json["icon_data"],
    onTap: json["on_tap"],
    bgColor: json["bg_color"],
    txColor: json["tx_color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "icon_data": iconData,
    "on_tap": onTap,
    "bg_color": bgColor,
    "tx_color": txColor,
  };
}
