class AssetLoanDetailModel {
  int? assetLoanId;
  Asset? asset;
  Applicant? applicant;
  Responsibility? responsibility;
  Bos? bos;
  String? eventName;
  String? eventPlace;
  DateTime? eventDateStart;
  DateTime? eventDateFinish;
  DateTime? loanDate;
  String? vehicleEquipment;
  String? vehicleEquipmentCondition;
  String? vehicleCondition;
  String? fuelImage;
  String? docFile;
  String? isApprove;
  List<Member>? members;

  AssetLoanDetailModel({
    this.assetLoanId,
    this.asset,
    this.applicant,
    this.responsibility,
    this.bos,
    this.eventName,
    this.eventPlace,
    this.eventDateStart,
    this.eventDateFinish,
    this.loanDate,
    this.vehicleEquipment,
    this.vehicleEquipmentCondition,
    this.vehicleCondition,
    this.fuelImage,
    this.docFile,
    this.isApprove,
    this.members,
  });

  factory AssetLoanDetailModel.fromJson(Map<String, dynamic> json) =>
      AssetLoanDetailModel(
        assetLoanId: json["asset_loan_id"],
        asset: json["asset"] == null ? null : Asset.fromJson(json["asset"]),
        applicant: json["applicant"] == null
            ? null
            : Applicant.fromJson(json["applicant"]),
        responsibility: json["responsibility"] == null
            ? null
            : Responsibility.fromJson(json["responsibility"]),
        bos: json["bos"] == null ? null : Bos.fromJson(json["bos"]),
        eventName: json["event_name"],
        eventPlace: json["event_place"],
        eventDateStart: json["event_date_start"] == null
            ? null
            : DateTime.parse(json["event_date_start"]),
        eventDateFinish: json["event_date_finish"] == null
            ? null
            : DateTime.parse(json["event_date_finish"]),
        loanDate: json["loan_date"] == null
            ? null
            : DateTime.parse(json["loan_date"]),
        vehicleEquipment: json["vehicle_equipment"],
        vehicleEquipmentCondition: json["vehicle_equipment_condition"],
        vehicleCondition: json["vehicle_condition"],
        fuelImage: json["fuel_image"],
        docFile: json["doc_file"],
        isApprove: json["is_approve"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "asset_loan_id": assetLoanId,
    "asset": asset?.toJson(),
    "applicant": applicant?.toJson(),
    "responsibility": responsibility?.toJson(),
    "bos": bos?.toJson(),
    "event_name": eventName,
    "event_place": eventPlace,
    "event_date_start":
        "${eventDateStart!.year.toString().padLeft(4, '0')}-${eventDateStart!.month.toString().padLeft(2, '0')}-${eventDateStart!.day.toString().padLeft(2, '0')}",
    "event_date_finish":
        "${eventDateFinish!.year.toString().padLeft(4, '0')}-${eventDateFinish!.month.toString().padLeft(2, '0')}-${eventDateFinish!.day.toString().padLeft(2, '0')}",
    "loan_date":
        "${loanDate!.year.toString().padLeft(4, '0')}-${loanDate!.month.toString().padLeft(2, '0')}-${loanDate!.day.toString().padLeft(2, '0')}",
    "vehicle_equipment": vehicleEquipment,
    "vehicle_equipment_condition": vehicleEquipmentCondition,
    "vehicle_condition": vehicleCondition,
    "fuel_image": fuelImage,
    "doc_file": docFile,
    "is_approve": isApprove,
    "members": members == null
        ? []
        : List<dynamic>.from(members!.map((x) => x.toJson())),
  };
}

class Applicant {
  int? applicantId;
  String? applicantName;
  int? applicantNip;
  String? applicantLevel;
  String? applicantPosition;
  String? applicantGol;
  String? applicantPad;

  Applicant({
    this.applicantId,
    this.applicantName,
    this.applicantNip,
    this.applicantLevel,
    this.applicantPosition,
    this.applicantGol,
    this.applicantPad,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
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

class Asset {
  int? assetId;
  int? assetNup;
  String? assetName;
  String? assetPoliceNo;

  Asset({this.assetId, this.assetName, this.assetNup, this.assetPoliceNo});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetId: json["asset_id"],
    assetName: json["asset_name"],
    assetNup: json["asset_nup"],
    assetPoliceNo: json["asset_police_no"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "asset_name": assetName,
    "asset_nup": assetNup,
    "asset_police_no": assetPoliceNo,
  };
}

class Member {
  int? memberId;
  String? memberName;

  Member({this.memberId, this.memberName});

  factory Member.fromJson(Map<String, dynamic> json) =>
      Member(memberId: json["member_id"], memberName: json["member_name"]);

  Map<String, dynamic> toJson() => {
    "member_id": memberId,
    "member_name": memberName,
  };
}

class Responsibility {
  int? responsibilityId;
  String? responsibilityName;
  String? responsibilityPad;
  String? responsibilityApproval;

  Responsibility({
    this.responsibilityId,
    this.responsibilityPad,
    this.responsibilityName,
    this.responsibilityApproval,
  });

  factory Responsibility.fromJson(Map<String, dynamic> json) => Responsibility(
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

class Bos {
  int? bosId;
  String? bosName;
  String? bosPad;
  String? bosApproval;

  Bos({this.bosId, this.bosPad, this.bosApproval, this.bosName});

  factory Bos.fromJson(Map<String, dynamic> json) => Bos(
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
