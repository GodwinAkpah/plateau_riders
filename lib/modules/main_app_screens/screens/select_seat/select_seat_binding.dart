import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/select_seat/select_seat_controller.dart';

class SelectSeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectSeatController>(() => SelectSeatController());
  }
}