class SelectOptModel {
  int? id;
  dynamic code;
  String? policeNo;
  String? name;
  bool? isSelected;

  SelectOptModel({
    this.id,
    this.code,
    this.policeNo,
    this.name,
    this.isSelected,
  });

  factory SelectOptModel.fromJson(Map<String, dynamic> json) => SelectOptModel(
    id:
        json["stuff_id"] ??
        json["bmn_id"] ??
        json["subdistrict_id"] ??
        json["district_id"] ??
        json["city_id"] ??
        json["province_id"] ??
        json["location_id"] ??
        json["condition_id"] ??
        json["usage_id"] ??
        json["asset_id"] ??
        json["user_id"] ??
        0,
    code: json["stuff_code"] ?? json["nup"] ?? '',
    policeNo: json["police_no"] ?? '',
    name:
        json["stuff_name"] ??
        json["bmn_name"] ??
        json["province_name"] ??
        json["city_name"] ??
        json["district_name"] ??
        json["subdistrict_name"] ??
        json["location_name"] ??
        json["condition_name"] ??
        json["usage_name"] ??
        json["merk"] ??
        json["user_name"] ??
        '',
    isSelected: json["is_selected"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "police_no": policeNo,
    "name": name,
    "is_selected": isSelected,
  };
}
