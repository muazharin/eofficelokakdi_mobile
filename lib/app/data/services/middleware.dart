import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthMiddleware extends GetMiddleware {
  final box = SecureStorageService();

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var token = await box.getData('token');
    if (token == null || token.isEmpty) {
      return Get.rootDelegate.toNamed(Routes.LOGIN);
    } else {
      return JwtDecoder.isExpired(token)
          ? Get.rootDelegate.toNamed(Routes.LOGIN)
          : super.redirectDelegate(route);
    }
  }
}
