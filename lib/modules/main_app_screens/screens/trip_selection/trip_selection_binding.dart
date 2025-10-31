import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_controller.dart';


class TripSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripSelectionController>(
      () => TripSelectionController(),
    );
  }
}