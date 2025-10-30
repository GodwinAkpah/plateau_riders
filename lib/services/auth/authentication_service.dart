// // lib/services/authentication_service.dart
// import 'package:dio/dio.dart' as dio;
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:plateau_riders/routing/app_pages.dart';
// import 'package:plateau_riders/services/core_service.dart';
// import 'package:plateau_riders/services/models/api_response_T.dart';
// import 'package:plateau_riders/services/models/user_model.dart';
// import 'package:plateau_riders/services/models/register_response.dart'; // Keep for login/register flow

// class AuthenticationService extends GetxService {
//   final CoreService _coreService = Get.find<CoreService>();
//   final GetStorage _storage = GetStorage();

//   Rx<UserModel?> currentUser = Rx<UserModel?>(null);

//   Future<APIResponse<RegisterResponse>> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     final payload = {"email": email, "password": password};
//     final response = await _coreService.send('/auth/login', payload);

//     if (response.status == "success" && response.data != null) {
//       // This line creates the RegisterResponse object using the new factory.
//       final registerResponse = RegisterResponse.fromMap(response.data);
      
//       _storage.write('auth_token', registerResponse.authToken);
//       currentUser.value = registerResponse.user; // Update the globally accessible user
      
//       return APIResponse(status: "success", message: response.message, data: registerResponse);
//     }
//     return APIResponse(status: response.status, message: response.message, data: null);
//   }

//   Future<APIResponse<UserModel>> getUserProfile() async {
//     final response = await _coreService.fetch('/auth/me');

//     if (response.status == "success" && response.data != null) {
//       final user = UserModel.fromMap(response.data);
//       currentUser.value = user;
//       return APIResponse(status: "success", message: response.message, data: user);
//     }
//     return APIResponse(status: response.status, message: response.message, data: null);
//   }

//   void logout() {
//     _storage.remove('auth_token');
//     currentUser.value = null;
//     Get.offAllNamed(Routes.SIGN_IN);
//   }

//   // --- Other existing methods (register, password reset, OTP, updateMe, etc.) ---
//   // ... (keep your other methods as they are)
// }

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/core_service.dart';
import 'package:plateau_riders/services/models/api_response_T.dart';
import 'package:plateau_riders/services/models/user_model.dart';
import 'package:plateau_riders/services/models/register_response.dart';

class AuthenticationService extends GetxService {
  // --- FIX: The CoreService is now a final field, received from the outside ---
  final CoreService _coreService;
  final GetStorage _storage = GetStorage();

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  // --- FIX: This is the constructor that was missing ---
  // It requires a CoreService to be provided when the class is created.
  AuthenticationService(this._coreService);

  Future<APIResponse<RegisterResponse>> loginUser({
    required String email,
    required String password,
  }) async {
    final payload = {"email": email, "password": password};
    final response = await _coreService.send('/auth/login', payload);

    if (response.status == "success" && response.data != null) {
      final registerResponse = RegisterResponse.fromMap(response.data);
      _storage.write('auth_token', registerResponse.authToken);
      currentUser.value = registerResponse.user;
      return APIResponse(status: "success", message: response.message, data: registerResponse);
    }
    return APIResponse(status: response.status, message: response.message, data: null);
  }

  Future<APIResponse<UserModel>> getUserProfile() async {
    final response = await _coreService.fetch('/auth/me');

    if (response.status == "success" && response.data != null) {
      final user = UserModel.fromMap(response.data);
      currentUser.value = user;
      return APIResponse(status: "success", message: response.message, data: user);
    }
    return APIResponse(status: response.status, message: response.message, data: null);
  }

  void logout() {
    _storage.remove('auth_token');
    currentUser.value = null;
    Get.offAllNamed(Routes.SIGN_IN);
  }
}