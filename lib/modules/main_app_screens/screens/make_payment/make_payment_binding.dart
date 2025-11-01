import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/make_payment/make_payment_controller.dart';

class MakePaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MakePaymentController>(() => MakePaymentController());
  }
}