import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/auth/auth_service.dart';
import 'package:plateau_riders/services/models/api_response.dart';
import 'package:plateau_riders/services/service_manifest.dart';

class SignInScreenController extends GetxController {
  // --- DEPENDENCIES ---
  final AuthenticationService _authService =
      serviceLocator<AuthenticationService>();
  final _storage = GetStorage();

  // --- STATE & UI CONTROLLERS ---
  final formKey = GlobalKey<FormState>();
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailPhoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool obscurePassword = true;
  bool isLoading = false;
  bool emailPhoneIsSpecialState = true;
  final String backgroundImageUrl = 'assets/imgs/market.jpg';
  late VoidCallback _passwordFocusListener;

  // --- LIFECYCLE ---
  @override
  void onInit() {
    super.onInit();

    emailPhoneController.addListener(updateEmailPhoneSpecialState);
    emailPhoneFocusNode.addListener(updateEmailPhoneSpecialState);

    _passwordFocusListener = () => update();
    passwordFocusNode.addListener(_passwordFocusListener);

    updateEmailPhoneSpecialState();
  }

  @override
  void dispose() {
    emailPhoneController.removeListener(updateEmailPhoneSpecialState);
    emailPhoneFocusNode.removeListener(updateEmailPhoneSpecialState);
    passwordFocusNode.removeListener(_passwordFocusListener);

    // emailPhoneController.dispose();
    // passwordController.dispose();
    emailPhoneFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }
  // ----------------------------------------------------

  // --- LOGIC / ACTIONS ---
  void updateEmailPhoneSpecialState() {
    // Add a safety check to ensure the controller hasn't been disposed.
    if (isClosed) return;

    final bool newState = emailPhoneController.text.isEmpty;
    if (emailPhoneIsSpecialState != newState) {
      emailPhoneIsSpecialState = newState;
      update();
    }
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  void navigateToCreateAccount() {
    FocusScope.of(Get.context!).unfocus();

    // Get.toNamed(Routes.SETPASSWORDSCREEN);
    Get.toNamed(Routes.CREATEACCOUNTSCREEN);
  }

  void navigateToForgotPassword() {
    Get.toNamed(Routes.RESETPASSWORDSCREEN);
  }

  Future<void> performSignIn() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      update();

      final Map<String, dynamic> payload = {
        "login": emailPhoneController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final APIResponse response = await _authService.login(payload);
      print(response);

      isLoading = false;
      // Safety check: only update if the controller is still active.
      if (!isClosed) {
        update();
      }

      if (response.status == 'success') {
        final String token = response.data['auth_token'];
        final String userName = response.data['user']['fname'];
        final userData = response.data;

        await _storage.write('auth_token', token);
        await _storage.write('user_data', userData);
        await _storage.write('show_movie', true);
        Get.offAllNamed(Routes.MAINBOTTOMNAV);
        Get.snackbar(
          "Login Successful",
          "Welcome back, $userName!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        isLoading = false;
        update();
        Get.snackbar(
          "Login Failed",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
