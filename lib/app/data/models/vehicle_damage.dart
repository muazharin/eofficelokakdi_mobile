class VehicleDamageModel {
  int? vehicleDamageId;
  String? vehicleDamageItem;
  DateTime? vehicleDamageTime;
  String? vehicleDamageType;
  String? vehicleDamageNote;

  VehicleDamageModel({
    this.vehicleDamageId,
    this.vehicleDamageItem,
    this.vehicleDamageTime,
    this.vehicleDamageType,
    this.vehicleDamageNote,
  });

  factory VehicleDamageModel.fromJson(Map<String, dynamic> json) =>
      VehicleDamageModel(
        vehicleDamageId: json["vehicle_damage_id"],
        vehicleDamageItem: json["vehicle_damage_item"],
        vehicleDamageTime: json["vehicle_damage_time"] == null
            ? null
            : DateTime.parse(json["vehicle_damage_time"]),
        vehicleDamageType: json["vehicle_damage_type"],
        vehicleDamageNote: json["vehicle_damage_note"],
      );

  Map<String, dynamic> toJson() => {
    "vehicle_damage_id": vehicleDamageId,
    "vehicle_damage_item": vehicleDamageItem,
    "vehicle_damage_time":
        "${vehicleDamageTime!.year.toString().padLeft(4, '0')}-${vehicleDamageTime!.month.toString().padLeft(2, '0')}-${vehicleDamageTime!.day.toString().padLeft(2, '0')}",
    "vehicle_damage_type": vehicleDamageType,
    "vehicle_damage_note": vehicleDamageNote,
  };
}
