import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/auth/authentication_service.dart';

import 'package:plateau_riders/services/models/api_response_T.dart';
import 'package:plateau_riders/services/models/register_response.dart';

class SignInScreenController extends GetxController {
  // --- DEPENDENCIES ---
  final AuthenticationService _authService = Get.find<AuthenticationService>();
  final _storage = GetStorage();

  // --- STATE & UI CONTROLLERS ---
  final formKey = GlobalKey<FormState>();
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailPhoneFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  var obscurePassword = true.obs;
  var isLoading = false.obs;
  var emailPhoneIsSpecialState = true.obs;

  // --- LIFECYCLE ---
  @override
  void onInit() {
    super.onInit();
    emailPhoneController.addListener(updateEmailPhoneSpecialState);
  }

  @override
  void onClose() {
    emailPhoneController.removeListener(updateEmailPhoneSpecialState);
    emailPhoneController.dispose();
    passwordController.dispose();
    emailPhoneFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  // --- LOGIC / ACTIONS ---
  void updateEmailPhoneSpecialState() {
    emailPhoneIsSpecialState.value = emailPhoneController.text.isEmpty;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void navigateToCreateAccount() {
    // Get.toNamed(Routes.CREATE_ACCOUNT); // Update with your actual route name
  }

  void navigateToForgotPassword() {
    // Get.toNamed(Routes.FORGOT_PASSWORD); // Update with your actual route name
  }

  // Future<void> performSignIn() async {
  //   // Unfocus any text fields to hide the keyboard
  //   FocusScope.of(Get.context!).unfocus();

  //   if (formKey.currentState!.validate()) {
  //     isLoading.value = true;

  //     // Call the correct method name (`loginUser`) and pass named arguments.
  //     final APIResponse<RegisterResponse> response = await _authService.loginUser(
  //       email: emailPhoneController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );

  //     isLoading.value = false;

  //     if (response.status == 'success' && response.data != null) {
  //       // Access data in a type-safe way from the RegisterResponse object.
  //       // THIS WILL NOW WORK
  //       final String token = response.data!.authToken;
  //       final String userName = response.data!.user.firstname;
        
  //       // The service now handles the user object. We just need to persist the token.
  //       await _storage.write('auth_token', token);

  //       // Navigate to the main app screen upon successful login.
  //       Get.offAllNamed(Routes.MAINBOTTOMNAV);
        
  //       Get.snackbar(
  //         "Login Successful",
  //         "Welcome back, $userName!",
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green,
  //         colorText: Colors.white,
  //         margin: const EdgeInsets.all(12),
  //         borderRadius: 8,
  //       );
  //     } else {
  //       Get.snackbar(
  //         "Login Failed",
  //         response.message,
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         colorText: Colors.white,
  //         margin: const EdgeInsets.all(12),
  //         borderRadius: 8,
  //       );
  //     }
  //   }
  // }
   Future<void> performSignIn() async {
    // Unfocus any text fields to hide the keyboard
    FocusScope.of(Get.context!).unfocus();

    print('[DEBUG] "Continue" button pressed. Starting sign-in process...');

    final isFormValid = formKey.currentState?.validate() ?? false;
    print('[DEBUG] Is form valid? -> $isFormValid');

    if (isFormValid) {
      isLoading.value = true;

      try {
        print('[DEBUG] Calling authService.loginUser with email: "${emailPhoneController.text.trim()}"');

        final APIResponse<RegisterResponse> response = await _authService.loginUser(
          email: emailPhoneController.text.trim(),
          password: passwordController.text.trim(),
        );

        print('[DEBUG] API call finished.');
        print('[DEBUG] Response Status: ${response.status}');
        print('[DEBUG] Response Message: ${response.message}');
        
        // This is important to see the raw data from the server
        if (response.data != null) {
          print('[DEBUG] Response Data Token: ${response.data!.authToken}');
          print('[DEBUG] Response Data User: ${response.data!.user.firstname}');
        } else {
          print('[DEBUG] Response Data is NULL.');
        }

        isLoading.value = false;

        if (response.status == 'success' && response.data != null) {
          print('[SUCCESS] Login successful. Navigating to main app...');
          
          final String token = response.data!.authToken;
          final String userName = response.data!.user.firstname;
          
          await _storage.write('auth_token', token);

          Get.offAllNamed(Routes.MAINBOTTOMNAV);
          
          Get.snackbar(
            "Login Successful",
            "Welcome back, $userName!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(12),
            borderRadius: 8,
          );
        } else {
          print('[ERROR] Login failed logically. Showing error snackbar.');
          Get.snackbar(
            "Login Failed",
            response.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.all(12),
            borderRadius: 8,
          );
        }
      } catch (e, stackTrace) {
        // This will catch any unexpected crashes during the API call or data parsing.
        isLoading.value = false;
        print('[FATAL ERROR] An exception occurred during sign-in: $e');
        print('[FATAL ERROR] Stack Trace: $stackTrace');
        Get.snackbar(
          "An Error Occurred",
          "Something went wrong. Please try again. Details: $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 8,
        );
      }
    }
  }
}