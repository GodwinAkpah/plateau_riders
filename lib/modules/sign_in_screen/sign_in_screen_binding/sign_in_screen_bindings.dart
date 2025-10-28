// lib/modules/sign_in_screen/sign_in_screen_binding.dart


import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_controller/sign_in_screen_controllers.dart';
import 'package:get/get.dart';

// Name corrected for consistency
class SignInScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInScreenController>(
          () =>  SignInScreenController(),
    );
  }
}