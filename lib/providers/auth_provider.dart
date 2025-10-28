import 'package:plateau_riders/routing/app_pages.dart';


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';


class AuthProvider extends GetxService {
  Future<AuthProvider> init() async => this;
  GetStorage localStorage = GetStorage();

  setToken(String token) {
    localStorage.write('token', token);
  }

  // logout
  void logout({
    route = Routes.SIGN_IN,
    title = "Session expired",
    msg = 'To continue please sign in again',
 
  }) {
    localStorage.remove('token');
    Get.offAllNamed(
      Routes.SIGN_IN,
    );
    if (title != '') {
      // Helpers.showToast(message: msg);
    }
  }
}
