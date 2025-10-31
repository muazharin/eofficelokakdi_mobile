import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/asset/bindings/asset_binding.dart';
import '../modules/asset/views/asset_view.dart';
import '../modules/asset_add/bindings/asset_add_binding.dart';
import '../modules/asset_add/views/asset_add_view.dart';
import '../modules/asset_detail/bindings/asset_detail_binding.dart';
import '../modules/asset_detail/views/asset_detail_view.dart';
import '../modules/asset_filter/bindings/asset_filter_binding.dart';
import '../modules/asset_filter/views/asset_filter_view.dart';
import '../modules/asset_history/bindings/asset_history_binding.dart';
import '../modules/asset_history/views/asset_history_view.dart';
import '../modules/borrow/bindings/borrow_binding.dart';
import '../modules/borrow/views/borrow_view.dart';
import '../modules/borrow_add/bindings/borrow_add_binding.dart';
import '../modules/borrow_add/views/borrow_add_view.dart';
import '../modules/borrow_detail/bindings/borrow_detail_binding.dart';
import '../modules/borrow_detail/views/borrow_detail_view.dart';
import '../modules/download_file/bindings/download_file_binding.dart';
import '../modules/download_file/views/download_file_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/open_pdf/bindings/open_pdf_binding.dart';
import '../modules/open_pdf/views/open_pdf_view.dart';
import '../modules/outbox/bindings/outbox_binding.dart';
import '../modules/outbox/views/outbox_view.dart';
import '../modules/outbox_add/bindings/outbox_add_binding.dart';
import '../modules/outbox_add/views/outbox_add_view.dart';
import '../modules/photo/bindings/photo_binding.dart';
import '../modules/photo/views/photo_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/profile_edit/bindings/profile_edit_binding.dart';
import '../modules/profile_edit/views/profile_edit_view.dart';
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
    GetPage(
      name: _Paths.DOWNLOAD_FILE,
      page: () => const DownloadFileView(),
      binding: DownloadFileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.OUTBOX,
      page: () => const OutboxView(),
      binding: OutboxBinding(),
    ),
    GetPage(
      name: _Paths.PHOTO,
      page: () => const PhotoView(),
      binding: PhotoBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
    ),
    GetPage(
      name: _Paths.OUTBOX_ADD,
      page: () => const OutboxAddView(),
      binding: OutboxAddBinding(),
    ),
    GetPage(
      name: _Paths.BORROW,
      page: () => const BorrowView(),
      binding: BorrowBinding(),
    ),
    GetPage(
      name: _Paths.ASSET_HISTORY,
      page: () => const AssetHistoryView(),
      binding: AssetHistoryBinding(),
    ),
    GetPage(
      name: _Paths.BORROW_ADD,
      page: () => const BorrowAddView(),
      binding: BorrowAddBinding(),
    ),
    GetPage(
      name: _Paths.BORROW_DETAIL,
      page: () => const BorrowDetailView(),
      binding: BorrowDetailBinding(),
    ),
    GetPage(
      name: _Paths.OPEN_PDF,
      page: () => const OpenPdfView(),
      binding: OpenPdfBinding(),
    ),
  ];
}
