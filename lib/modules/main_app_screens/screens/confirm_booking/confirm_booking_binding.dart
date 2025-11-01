import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/confirm_booking/confirm_booking_controller.dart';

class ConfirmBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmBookingController>(() => ConfirmBookingController());
  }
}