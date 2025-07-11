class AssetModel {
  int? assetId;
  String? assetName;
  String? nup;
  String? merk;
  Stuff? stuff;
  Bmn? bmn;
  Satker? satker;
  Condition? condition;

  AssetModel({
    this.assetId,
    this.assetName,
    this.nup,
    this.merk,
    this.stuff,
    this.bmn,
    this.satker,
    this.condition,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    assetId: json["asset_id"],
    assetName: json["asset_name"],
    nup: json["nup"],
    merk: json["merk"],
    stuff: json["stuff"] == null ? null : Stuff.fromJson(json["stuff"]),
    bmn: json["bmn"] == null ? null : Bmn.fromJson(json["bmn"]),
    satker: json["satker"] == null ? null : Satker.fromJson(json["satker"]),
    condition: json["condition"] == null
        ? null
        : Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "asset_name": assetName,
    "nup": nup,
    "merk": merk,
    "stuff": stuff?.toJson(),
    "bmn": bmn?.toJson(),
    "satker": satker?.toJson(),
    "condition": condition?.toJson(),
  };
}

class Bmn {
  int? bmnId;
  String? bmnName;

  Bmn({this.bmnId, this.bmnName});

  factory Bmn.fromJson(Map<String, dynamic> json) =>
      Bmn(bmnId: json["bmn_id"], bmnName: json["bmn_name"]);

  Map<String, dynamic> toJson() => {"bmn_id": bmnId, "bmn_name": bmnName};
}

class Condition {
  int? conditionId;
  String? conditionName;

  Condition({this.conditionId, this.conditionName});

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    conditionId: json["condition_id"],
    conditionName: json["condition_name"],
  );

  Map<String, dynamic> toJson() => {
    "condition_id": conditionId,
    "condition_name": conditionName,
  };
}

class Satker {
  int? satkerId;
  String? satkerCode;
  String? satkerName;

  Satker({this.satkerId, this.satkerCode, this.satkerName});

  factory Satker.fromJson(Map<String, dynamic> json) => Satker(
    satkerId: json["satker_id"],
    satkerCode: json["satker_code"],
    satkerName: json["satker_name"],
  );

  Map<String, dynamic> toJson() => {
    "satker_id": satkerId,
    "satker_code": satkerCode,
    "satker_name": satkerName,
  };
}

class Stuff {
  int? stuffId;
  String? stuffCode;
  String? stuffName;

  Stuff({this.stuffId, this.stuffCode, this.stuffName});

  factory Stuff.fromJson(Map<String, dynamic> json) => Stuff(
    stuffId: json["stuff_id"],
    stuffCode: json["stuff_code"],
    stuffName: json["stuff_name"],
  );

  Map<String, dynamic> toJson() => {
    "stuff_id": stuffId,
    "stuff_code": stuffCode,
    "stuff_name": stuffName,
  };
}
