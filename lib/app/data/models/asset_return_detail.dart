class AssetReturnDetailModel {
  int? assetReturnId;
  int? assetLoanId;
  AssetReturn? asset;
  ApplicantReturn? applicant;
  ResponsibilityReturn? responsibility;
  BosReturn? bos;
  DateTime? returnDate;
  String? vehicleEquipment;
  String? vehicleEquipmentCondition;
  String? vehicleCondition;
  String? fuelImage;
  String? docFile;
  String? isApprove;
  List<VehicleDamage>? vehicleDamage;

  AssetReturnDetailModel({
    this.assetReturnId,
    this.assetLoanId,
    this.asset,
    this.applicant,
    this.responsibility,
    this.bos,
    this.returnDate,
    this.vehicleEquipment,
    this.vehicleEquipmentCondition,
    this.vehicleCondition,
    this.fuelImage,
    this.docFile,
    this.isApprove,
    this.vehicleDamage,
  });

  factory AssetReturnDetailModel.fromJson(Map<String, dynamic> json) =>
      AssetReturnDetailModel(
        assetReturnId: json["asset_return_id"],
        assetLoanId: json["asset_loan_id"],
        asset: json["asset"] == null
            ? null
            : AssetReturn.fromJson(json["asset"]),
        applicant: json["applicant"] == null
            ? null
            : ApplicantReturn.fromJson(json["applicant"]),
        responsibility: json["responsibility"] == null
            ? null
            : ResponsibilityReturn.fromJson(json["responsibility"]),
        bos: json["bos"] == null ? null : BosReturn.fromJson(json["bos"]),
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
        vehicleEquipment: json["vehicle_equipment"],
        vehicleEquipmentCondition: json["vehicle_equipment_condition"],
        vehicleCondition: json["vehicle_condition"],
        fuelImage: json["fuel_image"],
        docFile: json["doc_file"],
        isApprove: json["is_approve"],
        vehicleDamage: json["vehicle_damage"] == null
            ? []
            : List<VehicleDamage>.from(
                json["vehicle_damage"]!.map((x) => VehicleDamage.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "asset_return_id": assetReturnId,
    "asset_loan_id": assetLoanId,
    "asset": asset?.toJson(),
    "applicant": applicant?.toJson(),
    "responsibility": responsibility?.toJson(),
    "bos": bos?.toJson(),
    "return_date":
        "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
    "vehicle_equipment": vehicleEquipment,
    "vehicle_equipment_condition": vehicleEquipmentCondition,
    "vehicle_condition": vehicleCondition,
    "fuel_image": fuelImage,
    "doc_file": docFile,
    "is_approve": isApprove,
    "vehicle_damage": vehicleDamage == null
        ? []
        : List<dynamic>.from(vehicleDamage!.map((x) => x.toJson())),
  };
}

class ApplicantReturn {
  int? applicantId;
  String? applicantName;
  int? applicantNip;
  String? applicantLevel;
  String? applicantPosition;
  String? applicantGol;
  String? applicantPad;

  ApplicantReturn({
    this.applicantId,
    this.applicantName,
    this.applicantNip,
    this.applicantLevel,
    this.applicantPosition,
    this.applicantGol,
    this.applicantPad,
  });

  factory ApplicantReturn.fromJson(Map<String, dynamic> json) =>
      ApplicantReturn(
        applicantId: json["applicant_id"],
        applicantName: json["applicant_name"],
        applicantNip: json["applicant_nip"],
        applicantLevel: json["applicant_level"],
        applicantPosition: json["applicant_position"],
        applicantGol: json["applicant_gol"],
        applicantPad: json["applicant_pad"],
      );

  Map<String, dynamic> toJson() => {
    "applicant_id": applicantId,
    "applicant_name": applicantName,
    "applicant_nip": applicantNip,
    "applicant_level": applicantLevel,
    "applicant_position": applicantPosition,
    "applicant_gol": applicantGol,
    "applicant_pad": applicantPad,
  };
}

class AssetReturn {
  int? assetId;
  int? assetNup;
  String? assetName;
  String? assetPoliceNo;

  AssetReturn({
    this.assetId,
    this.assetNup,
    this.assetName,
    this.assetPoliceNo,
  });

  factory AssetReturn.fromJson(Map<String, dynamic> json) => AssetReturn(
    assetId: json["asset_id"],
    assetNup: json["asset_nup"],
    assetName: json["asset_name"],
    assetPoliceNo: json["asset_police_no"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "asset_nup": assetNup,
    "asset_name": assetName,
    "asset_police_no": assetPoliceNo,
  };
}

class BosReturn {
  int? bosId;
  String? bosName;
  String? bosPad;
  String? bosApproval;

  BosReturn({this.bosId, this.bosName, this.bosPad, this.bosApproval});

  factory BosReturn.fromJson(Map<String, dynamic> json) => BosReturn(
    bosId: json["bos_id"],
    bosName: json["bos_name"],
    bosPad: json["bos_pad"],
    bosApproval: json["bos_approval"],
  );

  Map<String, dynamic> toJson() => {
    "bos_id": bosId,
    "bos_name": bosName,
    "bos_pad": bosPad,
    "bos_approval": bosApproval,
  };
}

class ResponsibilityReturn {
  int? responsibilityId;
  String? responsibilityName;
  String? responsibilityPad;
  String? responsibilityApproval;

  ResponsibilityReturn({
    this.responsibilityId,
    this.responsibilityName,
    this.responsibilityPad,
    this.responsibilityApproval,
  });

  factory ResponsibilityReturn.fromJson(Map<String, dynamic> json) =>
      ResponsibilityReturn(
        responsibilityId: json["responsibility_id"],
        responsibilityName: json["responsibility_name"],
        responsibilityPad: json["responsibility_pad"],
        responsibilityApproval: json["responsibility_approval"],
      );

  Map<String, dynamic> toJson() => {
    "responsibility_id": responsibilityId,
    "responsibility_name": responsibilityName,
    "responsibility_pad": responsibilityPad,
    "responsibility_approval": responsibilityApproval,
  };
}

class VehicleDamage {
  int? vehicleDamageId;
  String? vehicleDamageItem;
  DateTime? vehicleDamageTime;
  String? vehicleDamageType;
  String? vehicleDamageNote;

  VehicleDamage({
    this.vehicleDamageId,
    this.vehicleDamageItem,
    this.vehicleDamageTime,
    this.vehicleDamageType,
    this.vehicleDamageNote,
  });

  factory VehicleDamage.fromJson(Map<String, dynamic> json) => VehicleDamage(
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
