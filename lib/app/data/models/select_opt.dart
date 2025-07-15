class SelectOptModel {
  int? id;
  dynamic code;
  String? name;

  SelectOptModel({this.id, this.code, this.name});

  factory SelectOptModel.fromJson(Map<String, dynamic> json) => SelectOptModel(
    id:
        json["stuff_id"] ??
        json["bmn_id"] ??
        json["subdistrict_id"] ??
        json["district_id"] ??
        json["city_id"] ??
        json["province_id"] ??
        json["location_id"] ??
        0,
    code: json["stuff_code"] ?? '',
    name:
        json["stuff_name"] ??
        json["bmn_name"] ??
        json["province_name"] ??
        json["city_name"] ??
        json["district_name"] ??
        json["subdistrict_name"] ??
        json["location_name"] ??
        '',
  );

  Map<String, dynamic> toJson() => {"id": id, "code": code, "name": name};
}
