import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/bookings_list/bookings_list_controller.dart';

class BookingsListBinding extends Bindings {
  @override
  void dependencies() {
    // We use lazyPut so the controller is only created when the "Trips" tab is first visited
    Get.lazyPut<BookingsListController>(() => BookingsListController());
  }
}