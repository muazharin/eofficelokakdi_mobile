import 'package:eoffice/app/data/models/select_opt.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AssetAddController extends GetxController {
  var key = GlobalKey<FormState>();
  var merk = TextEditingController();
  var bmnName = TextEditingController();
  var bmn = SelectOptModel();
  var stuffCode = TextEditingController();
  var stuff = SelectOptModel();
  var nup = TextEditingController();
  var conditionId = TextEditingController();
  var intraExtra = TextEditingController();
  var isUsed = TextEditingController();
  var documentType = TextEditingController();
  var documentNo = TextEditingController();
  var bpkpNo = TextEditingController();
  var policeNo = TextEditingController();
  var certificateStatus = TextEditingController();
  var certificateNo = TextEditingController();
  var name = TextEditingController();
  var firstBookDate = TextEditingController();
  var acquisitionDate = TextEditingController();
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
  var usageStatusId = TextEditingController();
  var pspNo = TextEditingController();
  var pspDate = TextEditingController();
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

  void handleBackButton() {
    Get.rootDelegate.popRoute();
  }

  void handleSelectOpt(dynamic arg) {
    Get.rootDelegate.toNamed(Routes.SELECT_OPT, arguments: arg).then((v) {
      if (v != null) {
        switch (arg['title']) {
          case 'Jenis BMN':
            bmn = v as SelectOptModel;
            bmnName.text = "${bmn.name}";
            update();
            break;
          case 'Kode Barang':
            stuff = v as SelectOptModel;
            stuffCode.text = "${stuff.code}";
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
}
