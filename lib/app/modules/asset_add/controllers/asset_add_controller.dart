import 'dart:convert';

import 'package:eoffice/app/data/models/asset.dart';
import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/data/services/api.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/data/widgets/snackbar_custom.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AssetAddController extends GetxController {
  var arg = Get.arguments;
  var isEdit = false;
  var title = "Tambah";
  var dataEdit = AssetModel();
  var key = GlobalKey<FormState>();
  var isLoading = false;
  var merk = TextEditingController();
  var assetType = TextEditingController();
  var bmnName = TextEditingController();
  var bmn = SelectOptModel();
  var stuffCode = TextEditingController();
  var stuff = SelectOptModel();
  var nup = TextEditingController();
  var conditionName = TextEditingController();
  var condition = SelectOptModel();
  var intraExtra = TextEditingController();
  var documentType = TextEditingController();
  var documentNo = TextEditingController();
  var bpkpNo = TextEditingController();
  var policeNo = TextEditingController();
  var certificateStatus = TextEditingController();
  var certificateNo = TextEditingController();
  var name = TextEditingController();
  var firstBookDate = TextEditingController();
  var firstBookDateFormat = DateTime.now();
  var acquisitionDate = TextEditingController();
  var acquisitionDateFormat = DateTime.now();
  var firstEarningValue = TextEditingController();
  var mutationValue = TextEditingController();
  var earnedValue = TextEditingController();
  var depreciationValue = TextEditingController();
  var bookValue = TextEditingController();
  var totalArea = TextEditingController();
  var landAreaForBuilding = TextEditingController();
  var landAreaForEnvFacilities = TextEditingController();
  var vacantLandArea = TextEditingController();
  var buildingLandArea = TextEditingController();
  var noOfPhotos = TextEditingController();
  var usageStatusName = TextEditingController();
  var usageStatus = SelectOptModel();
  var pspNo = TextEditingController();
  var pspDate = TextEditingController();
  var pspDateFormat = DateTime.now();
  var address = TextEditingController();
  var rtRw = TextEditingController();
  var provinceName = TextEditingController();
  var province = SelectOptModel();
  var cityName = TextEditingController();
  var city = SelectOptModel();
  var districtName = TextEditingController();
  var district = SelectOptModel();
  var subdistrictName = TextEditingController();
  var subdistrict = SelectOptModel();
  var postalCode = TextEditingController();
  var sbsk = TextEditingController();
  var locationName = TextEditingController();
  var location = SelectOptModel();

  @override
  void onInit() {
    if (arg != null) {
      handleIsEdit();
    }
    super.onInit();
  }

  void handleIsEdit() {
    isEdit = true;
    title = "Edit";
    dataEdit = arg as AssetModel;
    merk.text = dataEdit.merk!;
    nup.text = "${dataEdit.nup}";
    assetType.text = dataEdit.assetType!;
    bmnName.text = dataEdit.bmn!.bmnName!;
    bmn = SelectOptModel(id: dataEdit.bmn!.bmnId, name: dataEdit.bmn!.bmnName);
    stuffCode.text = dataEdit.stuff!.stuffName!;
    stuff = SelectOptModel(
      id: dataEdit.stuff!.stuffId,
      name: dataEdit.stuff!.stuffName,
    );
    conditionName.text = dataEdit.condition!.conditionName!;
    condition = SelectOptModel(
      id: dataEdit.condition!.conditionId,
      name: dataEdit.condition!.conditionName,
    );
    intraExtra.text = dataEdit.intraExtra!;
    documentType.text = dataEdit.documentType!;
    documentNo.text = dataEdit.documentNo!;
    bpkpNo.text = dataEdit.bpkpNo!;
    policeNo.text = dataEdit.policeNo!;
    certificateStatus.text = dataEdit.certificateStatus!;
    certificateNo.text = dataEdit.certificateNo!;
    name.text = dataEdit.name!;
    firstBookDateFormat = dataEdit.firstBookDate!;
    firstBookDate.text = DateFormat(
      "dd MMMM yyyy",
    ).format(dataEdit.firstBookDate!);
    acquisitionDateFormat = dataEdit.acquisitionDate!;
    acquisitionDate.text = DateFormat(
      "dd MMMM yyyy",
    ).format(dataEdit.acquisitionDate!);
    firstEarningValue.text = "${dataEdit.firstEarningValue}";
    mutationValue.text = "${dataEdit.mutationValue}";
    earnedValue.text = "${dataEdit.earnedValue}";
    depreciationValue.text = "${dataEdit.depreciationValue}";
    bookValue.text = "${dataEdit.bookValue}";
    totalArea.text = "${dataEdit.totalLandArea}";
    landAreaForBuilding.text = "${dataEdit.landAreaForBuilding}";
    landAreaForEnvFacilities.text = "${dataEdit.landAreaForEnvFacilities}";
    vacantLandArea.text = "${dataEdit.vacantLandArea}";
    buildingLandArea.text = "${dataEdit.buildingLandArea}";
    noOfPhotos.text = "${dataEdit.noOfPhotos}";
    usageStatusName.text = dataEdit.usageStatus!.usageName!;
    usageStatus = SelectOptModel(
      id: dataEdit.usageStatus!.usageId,
      name: dataEdit.usageStatus!.usageName,
    );
    pspNo.text = "${dataEdit.pspNo}";
    pspDateFormat = dataEdit.pspDate!;
    pspDate.text = DateFormat("dd MMMM yyyy").format(dataEdit.pspDate!);
    address.text = "${dataEdit.address}";
    rtRw.text = "${dataEdit.rtRw}";
    provinceName.text = dataEdit.province!.provinceName!;
    province = SelectOptModel(
      id: dataEdit.province!.provinceId,
      name: dataEdit.province!.provinceName,
    );
    cityName.text = dataEdit.city!.cityName!;
    city = SelectOptModel(
      id: dataEdit.city!.cityId,
      name: dataEdit.city!.cityName,
    );
    districtName.text = dataEdit.district!.districtName!;
    district = SelectOptModel(
      id: dataEdit.district!.districtId,
      name: dataEdit.district!.districtName,
    );
    subdistrictName.text = dataEdit.subdistrict!.subdistrictName!;
    subdistrict = SelectOptModel(
      id: dataEdit.subdistrict!.subdistrictId,
      name: dataEdit.subdistrict!.subdistrictName,
    );
    postalCode.text = "${dataEdit.postalCode}";
    sbsk.text = "${dataEdit.sbsk}";
    locationName.text = dataEdit.location!.locationName!;
    location = SelectOptModel(
      id: dataEdit.location!.locationId,
      name: dataEdit.location!.locationName,
    );
    update();
  }

  void handleBackButton() {
    Get.back();
  }

  void handleSelectDate(DateTime date, String name) {
    switch (name) {
      case "Tanggal Buku Pertama":
        firstBookDate.text = DateFormat("dd MMMM yyyy").format(date);
        firstBookDateFormat = date;
        update();
        break;
      case "Tanggal Akuisisi":
        acquisitionDate.text = DateFormat("dd MMMM yyyy").format(date);
        acquisitionDateFormat = date;
        update();
        break;
      case "Tanggal PSP":
        pspDate.text = DateFormat("dd MMMM yyyy").format(date);
        pspDateFormat = date;
        update();
        break;
      default:
    }
  }

  void handleSelectOpt(dynamic arg) {
    Get.toNamed(Routes.SELECT_OPT, arguments: arg)!.then((v) {
      if (v != null) {
        switch (arg['title']) {
          case 'Jenis BMN':
            bmn = v as SelectOptModel;
            bmnName.text = "${bmn.name}";
            stuff = SelectOptModel();
            stuffCode.text = '';
            update();
            break;
          case 'Kondisi':
            condition = v as SelectOptModel;
            conditionName.text = "${condition.name}";
            update();
            break;
          case 'Kode Barang':
            stuff = v as SelectOptModel;
            stuffCode.text = "${stuff.name}";
            update();
            break;
          case 'Lokasi Ruang':
            location = v as SelectOptModel;
            locationName.text = "${location.name}";
            update();
            break;
          case 'Status Penggunaan':
            usageStatus = v as SelectOptModel;
            usageStatusName.text = "${usageStatus.name}";
            update();
            break;
          case 'Provinsi':
            province = v as SelectOptModel;
            provinceName.text = "${province.name}";
            city = SelectOptModel();
            cityName.text = '';
            district = SelectOptModel();
            districtName.text = '';
            subdistrict = SelectOptModel();
            subdistrictName.text = '';
            update();
            break;
          case 'Kota/Kab':
            city = v as SelectOptModel;
            cityName.text = "${city.name}";
            district = SelectOptModel();
            districtName.text = '';
            subdistrict = SelectOptModel();
            subdistrictName.text = '';
            update();
            break;
          case 'Kecamatan':
            district = v as SelectOptModel;
            districtName.text = "${district.name}";
            subdistrict = SelectOptModel();
            subdistrictName.text = '';
            update();
            break;
          case 'Kelurahan':
            subdistrict = v as SelectOptModel;
            subdistrictName.text = "${subdistrict.name}";
            update();
            break;
          default:
        }
      }
    });
  }

  void handleSubmit() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      if (isEdit) {
        try {
          final response = await Api().putWithToken(
            path: AppVariable.asset,
            queryParameters: {"asset_id": dataEdit.assetId},
            data: {
              "bmn_id": bmn.id,
              "satker_id": 1,
              "stuff_id": stuff.id,
              "nup": int.parse(nup.text),
              "merk": merk.text,
              "asset_type": assetType.text,
              "condition_id": condition.id,
              "intra_extra": "intra",
              "is_used": false,
              "document_type": documentType.text,
              "document_no": documentNo.text,
              "bpkp_no": bpkpNo.text,
              "police_no": policeNo.text,
              "certificate_status": certificateStatus.text,
              "certificate_no": certificateNo.text,
              "name": name.text,
              "first_book_date": DateFormat(
                "yyyy-MM-dd",
              ).format(firstBookDateFormat),
              "acquisition_date": DateFormat(
                "yyyy-MM-dd",
              ).format(acquisitionDateFormat),
              "first_earning_value": int.parse(
                firstEarningValue.text.replaceAll(".", ""),
              ),
              "mutation_value": int.parse(
                mutationValue.text.replaceAll(".", ""),
              ),
              "earned_value": int.parse(earnedValue.text.replaceAll(".", "")),
              "depreciation_value": int.parse(
                depreciationValue.text.replaceAll(".", ""),
              ),
              "book_value": int.parse(bookValue.text.replaceAll(".", "")),
              "total_area": int.parse(totalArea.text.replaceAll(".", "")),
              "land_area_for_building": int.parse(
                landAreaForBuilding.text.replaceAll(".", ""),
              ),
              "land_area_for_env_facilities": int.parse(
                landAreaForEnvFacilities.text.replaceAll(".", ""),
              ),
              "vacant_land_area": int.parse(
                vacantLandArea.text.replaceAll(".", ""),
              ),
              "building_land_area": int.parse(
                buildingLandArea.text.replaceAll(".", ""),
              ),
              "no_of_photos": int.parse(noOfPhotos.text),
              "usage_status_id": usageStatus.id,
              "psp_no": pspNo.text,
              "psp_date": DateFormat("yyyy-MM-dd").format(pspDateFormat),
              "address": address.text,
              "rt_rw": rtRw.text,
              "province_id": province.id,
              "city_id": city.id,
              "district_id": district.id,
              "subdistrict_id": subdistrict.id,
              "postal_code": int.parse(postalCode.text),
              "sbsk": int.parse(sbsk.text),
              "location_id": location.id,
            },
          );
          var result = jsonDecode(response.toString());
          if (result['status']) {
            snackbarSuccess(message: result['message']);
            Get.until((route) => Get.currentRoute == Routes.ASSET);
          } else {
            snackbarDanger(message: "Terjadi Kesalahan!");
          }
        } catch (e) {
          print(e);
          snackbarDanger(message: "Terjadi Kesalahans");
        } finally {
          isLoading = false;
          update();
        }
      } else {
        try {
          final response = await Api().postWithToken(
            path: AppVariable.asset,
            data: {
              "bmn_id": bmn.id,
              "satker_id": 1,
              "stuff_id": stuff.id,
              "nup": int.parse(nup.text),
              "merk": merk.text,
              "asset_type": assetType.text,
              "condition_id": condition.id,
              "intra_extra": "intra",
              "is_used": condition.id == 1,
              "document_type": documentType.text,
              "document_no": documentNo.text,
              "bpkp_no": bpkpNo.text,
              "police_no": policeNo.text,
              "certificate_status": certificateStatus.text,
              "certificate_no": certificateNo.text,
              "name": name.text,
              "first_book_date": DateFormat(
                "yyyy-MM-dd",
              ).format(firstBookDateFormat),
              "acquisition_date": DateFormat(
                "yyyy-MM-dd",
              ).format(acquisitionDateFormat),
              "first_earning_value": int.parse(
                firstEarningValue.text.replaceAll(".", ""),
              ),
              "mutation_value": int.parse(
                mutationValue.text.replaceAll(".", ""),
              ),
              "earned_value": int.parse(earnedValue.text.replaceAll(".", "")),
              "depreciation_value": int.parse(
                depreciationValue.text.replaceAll(".", ""),
              ),
              "book_value": int.parse(bookValue.text.replaceAll(".", "")),
              "total_area": int.parse(totalArea.text.replaceAll(".", "")),
              "land_area_for_building": int.parse(
                landAreaForBuilding.text.replaceAll(".", ""),
              ),
              "land_area_for_env_facilities": int.parse(
                landAreaForEnvFacilities.text.replaceAll(".", ""),
              ),
              "vacant_land_area": int.parse(
                vacantLandArea.text.replaceAll(".", ""),
              ),
              "building_land_area": int.parse(
                buildingLandArea.text.replaceAll(".", ""),
              ),
              "no_of_photos": int.parse(noOfPhotos.text),
              "usage_status_id": usageStatus.id,
              "psp_no": pspNo.text,
              "psp_date": DateFormat("yyyy-MM-dd").format(pspDateFormat),
              "address": address.text,
              "rt_rw": rtRw.text,
              "province_id": province.id,
              "city_id": city.id,
              "district_id": district.id,
              "subdistrict_id": subdistrict.id,
              "postal_code": int.parse(postalCode.text),
              "sbsk": int.parse(sbsk.text),
              "location_id": location.id,
            },
          );
          var result = jsonDecode(response.toString());
          if (result['status']) {
            snackbarSuccess(message: result['message']);
            Get.until((route) => Get.currentRoute == Routes.ASSET);
          } else {
            snackbarDanger(message: "Terjadi Kesalahan");
          }
        } catch (e) {
          snackbarDanger(message: "Terjadi Kesalahan");
        } finally {
          isLoading = false;
          update();
        }
      }
    }
  }
}
