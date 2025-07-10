import 'package:flutter/material.dart';

class MenuModel {
  int? id;
  String? name;
  String? icon;
  Color? bgColor;
  Color? txColor;
  void Function()? onTap;

  MenuModel({
    this.id,
    this.name,
    this.icon,
    this.onTap,
    this.bgColor,
    this.txColor,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    onTap: json["on_tap"],
    bgColor: json["bg_color"],
    txColor: json["tx_color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "on_tap": onTap,
    "bg_color": bgColor,
    "tx_color": txColor,
  };
}
