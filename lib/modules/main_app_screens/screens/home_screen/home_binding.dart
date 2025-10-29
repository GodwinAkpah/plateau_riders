// lib/modules/main_app_screens/screens/home_screen/bindings/home_binding.dart

import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}