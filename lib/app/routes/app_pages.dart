import 'package:get/get.dart';

import '../modules/asset/bindings/asset_binding.dart';
import '../modules/asset/views/asset_view.dart';
import '../modules/asset_add/bindings/asset_add_binding.dart';
import '../modules/asset_add/views/asset_add_view.dart';
import '../modules/asset_detail/bindings/asset_detail_binding.dart';
import '../modules/asset_detail/views/asset_detail_view.dart';
import '../modules/asset_filter/bindings/asset_filter_binding.dart';
import '../modules/asset_filter/views/asset_filter_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/scanner/bindings/scanner_binding.dart';
import '../modules/scanner/views/scanner_view.dart';
import '../modules/select_opt/bindings/select_opt_binding.dart';
import '../modules/select_opt/views/select_opt_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transitionDuration: Duration(milliseconds: 1700),
    ),
    GetPage(
      name: _Paths.ASSET,
      page: () => const AssetView(),
      binding: AssetBinding(),
    ),
    GetPage(
      name: _Paths.ASSET_DETAIL,
      page: () => const AssetDetailView(),
      binding: AssetDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.ASSET_ADD,
      page: () => const AssetAddView(),
      binding: AssetAddBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_OPT,
      page: () => const SelectOptView(),
      binding: SelectOptBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.ASSET_FILTER,
      page: () => const AssetFilterView(),
      binding: AssetFilterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
    ),
  ];
}
