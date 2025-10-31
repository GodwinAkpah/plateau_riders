import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_controller.dart';

class PassengerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PassengerDetailsController>(
      () => PassengerDetailsController(),
    );
  }
}