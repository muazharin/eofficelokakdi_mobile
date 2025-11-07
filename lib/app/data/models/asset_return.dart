class GroupAssetReturn {
  GroupAssetReturn({this.name, this.riwayat});

  String? name;
  List<AssetReturnModel>? riwayat;

  factory GroupAssetReturn.fromJson(Map<String, dynamic> json) =>
      GroupAssetReturn(
        name: json["name"],
        riwayat: List<AssetReturnModel>.from(
          json["riwayat"].map((x) => AssetReturnModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "riwayat": List<dynamic>.from(riwayat!.map((x) => x.toJson())),
  };
}

class AssetReturnModel {
  int? assetReturnId;
  int? assetLoanId;
  AssetReturn? asset;
  ApplicantReturn? applicant;
  DateTime? returnDate;

  AssetReturnModel({
    this.assetReturnId,
    this.assetLoanId,
    this.asset,
    this.applicant,
    this.returnDate,
  });

  factory AssetReturnModel.fromJson(Map<String, dynamic> json) =>
      AssetReturnModel(
        assetReturnId: json["asset_return_id"],
        assetLoanId: json["asset_loan_id"],
        asset: json["asset"] == null
            ? null
            : AssetReturn.fromJson(json["asset"]),
        applicant: json["applicant"] == null
            ? null
            : ApplicantReturn.fromJson(json["applicant"]),
        returnDate: json["return_date"] == null
            ? null
            : DateTime.parse(json["return_date"]),
      );

  Map<String, dynamic> toJson() => {
    "asset_return_id": assetReturnId,
    "asset_loan_id": assetLoanId,
    "asset": asset?.toJson(),
    "applicant": applicant?.toJson(),
    "return_date":
        "${returnDate!.year.toString().padLeft(4, '0')}-${returnDate!.month.toString().padLeft(2, '0')}-${returnDate!.day.toString().padLeft(2, '0')}",
  };
}

class ApplicantReturn {
  int? applicantId;
  String? applicantName;
  double? applicantNip;
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
        applicantNip: json["applicant_nip"]?.toDouble(),
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
