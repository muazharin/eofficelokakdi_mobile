import 'package:flutter/material.dart';

class ChartDataModel {
  final int? chartId;
  final String? chartName;
  final Color? color;
  final double? chartTotal;

  ChartDataModel({this.color, this.chartId, this.chartName, this.chartTotal});

  factory ChartDataModel.fromJson(Map<String, dynamic> json) => ChartDataModel(
    chartId: json["asset_id"],
    chartName: '${json["acquisition_year"]}',
    chartTotal: json["total"]?.toDouble(),
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": chartId,
    "acquisition_year": chartName,
    "total": chartTotal,
    "color": color,
  };
}
