class AssetModel {
  int? assetId;
  Bmn? bmn;
  Satker? satker;
  Stuff? stuff;
  int? nup;
  String? merk;
  Condition? condition;
  int? age;
  String? assetType;
  String? intraExtra;
  bool? isUsed;
  bool? sbsnStatus;
  bool? bmnIdleStatus;
  bool? mitraStatus;
  bool? bpybds;
  bool? lostAppr;
  bool? rbAppr;
  bool? deleteAppr;
  bool? dktpHibah;
  bool? concessionService;
  bool? investmentProperty;
  String? documentType;
  String? documentNo;
  String? bpkpNo;
  String? policeNo;
  String? certificateStatus;
  String? certificateNo;
  String? name;
  DateTime? firstBookDate;
  DateTime? acquisitionDate;
  DateTime? deleteDate;
  int? firstEarningValue;
  int? mutationValue;
  int? earnedValue;
  int? depreciationValue;
  int? bookValue;
  int? totalLandArea;
  int? landAreaForBuilding;
  int? landAreaForEnvFacilities;
  int? vacantLandArea;
  int? buildingLandArea;
  int? buildingFootprintArea;
  int? areaOfUtilization;
  int? noOfFloors;
  int? noOfPhotos;
  UsageStatus? usageStatus;
  String? pspNo;
  DateTime? pspDate;
  String? address;
  String? rtRw;
  Subdistrict? subdistrict;
  District? district;
  City? city;
  Province? province;
  int? postalCode;
  int? sbsk;
  int? optimalization;
  String? occupant;
  String? user;
  String? kpknlCode;
  String? kpknlDesc;
  String? kancilDjknDesc;
  String? klName;
  String? e1Name;
  String? korwilName;
  String? regCode;
  Location? location;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  AssetModel({
    this.assetId,
    this.bmn,
    this.satker,
    this.stuff,
    this.nup,
    this.merk,
    this.condition,
    this.age,
    this.assetType,
    this.intraExtra,
    this.isUsed,
    this.sbsnStatus,
    this.bmnIdleStatus,
    this.mitraStatus,
    this.bpybds,
    this.lostAppr,
    this.rbAppr,
    this.deleteAppr,
    this.dktpHibah,
    this.concessionService,
    this.investmentProperty,
    this.documentType,
    this.documentNo,
    this.bpkpNo,
    this.policeNo,
    this.certificateStatus,
    this.certificateNo,
    this.name,
    this.firstBookDate,
    this.acquisitionDate,
    this.deleteDate,
    this.firstEarningValue,
    this.mutationValue,
    this.earnedValue,
    this.depreciationValue,
    this.bookValue,
    this.totalLandArea,
    this.landAreaForBuilding,
    this.landAreaForEnvFacilities,
    this.vacantLandArea,
    this.buildingLandArea,
    this.buildingFootprintArea,
    this.areaOfUtilization,
    this.noOfFloors,
    this.noOfPhotos,
    this.usageStatus,
    this.pspNo,
    this.pspDate,
    this.address,
    this.rtRw,
    this.subdistrict,
    this.district,
    this.city,
    this.province,
    this.postalCode,
    this.sbsk,
    this.optimalization,
    this.occupant,
    this.user,
    this.kpknlCode,
    this.kpknlDesc,
    this.kancilDjknDesc,
    this.klName,
    this.e1Name,
    this.korwilName,
    this.regCode,
    this.location,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) => AssetModel(
    assetId: json["asset_id"],
    bmn: json["Bmn"] == null ? null : Bmn.fromJson(json["Bmn"]),
    satker: json["Satker"] == null ? null : Satker.fromJson(json["Satker"]),
    stuff: json["Stuff"] == null ? null : Stuff.fromJson(json["Stuff"]),
    nup: json["nup"],
    merk: json["merk"],

    condition: json["Condition"] == null
        ? null
        : Condition.fromJson(json["Condition"]),
    age: json["age"],
    assetType: json["asset_type"],
    intraExtra: json["intra_extra"],
    isUsed: json["is_used"],
    sbsnStatus: json["sbsn_status"],
    bmnIdleStatus: json["bmn_idle_status"],
    mitraStatus: json["mitra_status"],
    bpybds: json["bpybds"],
    lostAppr: json["lost_appr"],
    rbAppr: json["rb_appr"],
    deleteAppr: json["delete_appr"],
    dktpHibah: json["dktp_hibah"],
    concessionService: json["concession_service"],
    investmentProperty: json["investment_property"],
    documentType: json["document_type"],
    documentNo: json["document_no"],
    bpkpNo: json["bpkp_no"],
    policeNo: json["police_no"],
    certificateStatus: json["certificate_status"],
    certificateNo: json["certificate_no"],
    name: json["name"],
    firstBookDate: json["first_book_date"] == null
        ? null
        : DateTime.parse(json["first_book_date"]),
    acquisitionDate: json["acquisition_date"] == null
        ? null
        : DateTime.parse(json["acquisition_date"]),
    deleteDate: json["delete_date"] == null
        ? null
        : DateTime.parse(json["delete_date"]),
    firstEarningValue: json["first_earning_value"],
    mutationValue: json["mutation_value"],
    earnedValue: json["earned_value"],
    depreciationValue: json["depreciation_value"],
    bookValue: json["book_value"],
    totalLandArea: json["total_land_area"],
    landAreaForBuilding: json["land_area_for_building"],
    landAreaForEnvFacilities: json["land_area_for_env_facilities"],
    vacantLandArea: json["vacant_land_area"],
    buildingLandArea: json["building_land_area"],
    buildingFootprintArea: json["building_footprint_area"],
    areaOfUtilization: json["area_of_utilization"],
    noOfFloors: json["no_of_floors"],
    noOfPhotos: json["no_of_photos"],

    usageStatus: json["UsageStatus"] == null
        ? null
        : UsageStatus.fromJson(json["UsageStatus"]),
    pspNo: json["psp_no"],
    pspDate: json["psp_date"] == null ? null : DateTime.parse(json["psp_date"]),
    address: json["address"],
    rtRw: json["rt_rw"],

    subdistrict: json["Subdistrict"] == null
        ? null
        : Subdistrict.fromJson(json["Subdistrict"]),

    district: json["District"] == null
        ? null
        : District.fromJson(json["District"]),

    city: json["City"] == null ? null : City.fromJson(json["City"]),

    province: json["Province"] == null
        ? null
        : Province.fromJson(json["Province"]),
    postalCode: json["postal_code"],
    sbsk: json["sbsk"],
    optimalization: json["optimalization"],
    occupant: json["occupant"],
    user: json["user"],
    kpknlCode: json["kpknl_code"],
    kpknlDesc: json["kpknl_desc"],
    kancilDjknDesc: json["kancil_djkn_desc"],
    klName: json["kl_name"],
    e1Name: json["e1_name"],
    korwilName: json["korwil_name"],
    regCode: json["reg_code"],

    location: json["Location"] == null
        ? null
        : Location.fromJson(json["Location"]),
    isDeleted: json["is_deleted"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "asset_id": assetId,
    "Bmn": bmn?.toJson(),
    "bmn": bmn?.toJson(),
    "Satker": satker?.toJson(),
    "satker": satker?.toJson(),
    "Stuff": stuff?.toJson(),
    "stuff": stuff?.toJson(),
    "nup": nup,
    "merk": merk,

    "Condition": condition?.toJson(),
    "age": age,
    "asset_type": assetType,
    "intra_extra": intraExtra,
    "is_used": isUsed,
    "sbsn_status": sbsnStatus,
    "bmn_idle_status": bmnIdleStatus,
    "mitra_status": mitraStatus,
    "bpybds": bpybds,
    "lost_appr": lostAppr,
    "rb_appr": rbAppr,
    "delete_appr": deleteAppr,
    "dktp_hibah": dktpHibah,
    "concession_service": concessionService,
    "investment_property": investmentProperty,
    "document_type": documentType,
    "document_no": documentNo,
    "bpkp_no": bpkpNo,
    "police_no": policeNo,
    "certificate_status": certificateStatus,
    "certificate_no": certificateNo,
    "name": name,
    "first_book_date": firstBookDate?.toIso8601String(),
    "acquisition_date": acquisitionDate?.toIso8601String(),
    "delete_date": deleteDate?.toIso8601String(),
    "first_earning_value": firstEarningValue,
    "mutation_value": mutationValue,
    "earned_value": earnedValue,
    "depreciation_value": depreciationValue,
    "book_value": bookValue,
    "total_land_area": totalLandArea,
    "land_area_for_building": landAreaForBuilding,
    "land_area_for_env_facilities": landAreaForEnvFacilities,
    "vacant_land_area": vacantLandArea,
    "building_land_area": buildingLandArea,
    "building_footprint_area": buildingFootprintArea,
    "area_of_utilization": areaOfUtilization,
    "no_of_floors": noOfFloors,
    "no_of_photos": noOfPhotos,

    "UsageStatus": usageStatus?.toJson(),
    "psp_no": pspNo,
    "psp_date": pspDate?.toIso8601String(),
    "address": address,
    "rt_rw": rtRw,

    "Subdistrict": subdistrict?.toJson(),

    "District": district?.toJson(),

    "City": city?.toJson(),

    "Province": province?.toJson(),
    "postal_code": postalCode,
    "sbsk": sbsk,
    "optimalization": optimalization,
    "occupant": occupant,
    "user": user,
    "kpknl_code": kpknlCode,
    "kpknl_desc": kpknlDesc,
    "kancil_djkn_desc": kancilDjknDesc,
    "kl_name": klName,
    "e1_name": e1Name,
    "korwil_name": korwilName,
    "reg_code": regCode,

    "Location": location?.toJson(),
    "is_deleted": isDeleted,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

class City {
  int? cityId;
  int? provinceId;
  String? cityName;

  City({this.cityId, this.provinceId, this.cityName});

  factory City.fromJson(Map<String, dynamic> json) => City(
    cityId: json["city_id"],
    provinceId: json["province_id"],
    cityName: json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "city_id": cityId,
    "province_id": provinceId,
    "city_name": cityName,
  };
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

class District {
  int? districtId;
  int? cityId;
  String? districtName;

  District({this.districtId, this.cityId, this.districtName});

  factory District.fromJson(Map<String, dynamic> json) => District(
    districtId: json["district_id"],
    cityId: json["city_id"],
    districtName: json["district_name"],
  );

  Map<String, dynamic> toJson() => {
    "district_id": districtId,
    "city_id": cityId,
    "district_name": districtName,
  };
}

class Location {
  int? locationId;
  String? locationName;

  Location({this.locationId, this.locationName});

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["location_id"],
    locationName: json["location_name"],
  );

  Map<String, dynamic> toJson() => {
    "location_id": locationId,
    "location_name": locationName,
  };
}

class Province {
  int? provinceId;
  String? provinceName;

  Province({this.provinceId, this.provinceName});

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    provinceId: json["province_id"],
    provinceName: json["province_name"],
  );

  Map<String, dynamic> toJson() => {
    "province_id": provinceId,
    "province_name": provinceName,
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
  String? stuffName;

  Stuff({this.stuffId, this.stuffName});

  factory Stuff.fromJson(Map<String, dynamic> json) =>
      Stuff(stuffId: json["stuff_id"], stuffName: json["stuff_name"]);

  Map<String, dynamic> toJson() => {
    "stuff_id": stuffId,
    "stuff_name": stuffName,
  };
}

class Subdistrict {
  int? subdistrictId;
  int? districtId;
  String? subdistrictName;

  Subdistrict({this.subdistrictId, this.districtId, this.subdistrictName});

  factory Subdistrict.fromJson(Map<String, dynamic> json) => Subdistrict(
    subdistrictId: json["subdistrict_id"],
    districtId: json["district_id"],
    subdistrictName: json["subdistrict_name"],
  );

  Map<String, dynamic> toJson() => {
    "subdistrict_id": subdistrictId,
    "district_id": districtId,
    "subdistrict_name": subdistrictName,
  };
}

class UsageStatus {
  int? usageId;
  String? usageName;

  UsageStatus({this.usageId, this.usageName});

  factory UsageStatus.fromJson(Map<String, dynamic> json) =>
      UsageStatus(usageId: json["usage_id"], usageName: json["usage_name"]);

  Map<String, dynamic> toJson() => {
    "usage_id": usageId,
    "usage_name": usageName,
  };
}
