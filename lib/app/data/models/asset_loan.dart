class GroupAssetLoan {
  GroupAssetLoan({this.name, this.riwayat});

  String? name;
  List<AssetLoanModel>? riwayat;

  factory GroupAssetLoan.fromJson(Map<String, dynamic> json) => GroupAssetLoan(
    name: json["name"],
    riwayat: List<AssetLoanModel>.from(
      json["riwayat"].map((x) => AssetLoanModel.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "riwayat": List<dynamic>.from(riwayat!.map((x) => x.toJson())),
  };
}

class AssetLoanModel {
  int? assetLoanId;
  Asset? asset;
  Applicant? applicant;
  String? eventName;
  DateTime? loanDate;

  AssetLoanModel({
    this.assetLoanId,
    this.asset,
    this.applicant,
    this.eventName,
    this.loanDate,
  });

  factory AssetLoanModel.fromJson(Map<String, dynamic> json) => AssetLoanModel(
    assetLoanId: json["asset_loan_id"],
    asset: json["asset"] == null ? null : Asset.fromJson(json["asset"]),
    applicant: json["applicant"] == null
        ? null
        : Applicant.fromJson(json["applicant"]),
    eventName: json["event_name"],
    loanDate: json["loan_date"] == null
        ? null
        : DateTime.parse(json["loan_date"]),
  );

  Map<String, dynamic> toJson() => {
    "asset_loan_id": assetLoanId,
    "asset": asset?.toJson(),
    "applicant": applicant?.toJson(),
    "event_name": eventName,
    "loan_date":
        "${loanDate!.year.toString().padLeft(4, '0')}-${loanDate!.month.toString().padLeft(2, '0')}-${loanDate!.day.toString().padLeft(2, '0')}",
  };
}

class Applicant {
  int? applicantId;
  String? applicantName;
  String? applicantLevel;
  String? applicantPosition;
  String? applicantGol;

  Applicant({
    this.applicantId,
    this.applicantName,
    this.applicantLevel,
    this.applicantPosition,
    this.applicantGol,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
    applicantId: json["applicant_id"],
    applicantName: json["applicant_name"],
    applicantLevel: json["applicant_level"],
    applicantPosition: json["applicant_position"],
    applicantGol: json["applicant_gol"],
  );

  Map<String, dynamic> toJson() => {
    "applicant_id": applicantId,
    "applicant_name": applicantName,
    "applicant_level": applicantLevel,
    "applicant_position": applicantPosition,
    "applicant_gol": applicantGol,
  };
}

class Asset {
  int? assetId;
  int? assetNup;
  String? assetName;

  Asset({this.assetId, this.assetNup, this.assetName});

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    assetId: json["asset_id"],
    assetNup: json["asset_nup"],
    assetName: json["asset_name"],
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "asset_nup": assetNup,
    "asset_name": assetName,
  };
}
