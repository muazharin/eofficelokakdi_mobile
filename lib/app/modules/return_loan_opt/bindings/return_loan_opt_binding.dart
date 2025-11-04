import 'package:get/get.dart';

import '../controllers/return_loan_opt_controller.dart';

class ReturnLoanOptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnLoanOptController>(
      () => ReturnLoanOptController(),
    );
  }
}
