import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/core_service.dart';
import 'package:plateau_riders/services/models/api_response_T.dart';
import 'package:plateau_riders/services/models/user_model.dart';
import 'package:plateau_riders/services/models/register_response.dart';

class AuthenticationService extends GetxService {
  final CoreService _coreService;
  final GetStorage _storage = GetStorage();

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  AuthenticationService(this._coreService);

  Future<APIResponse<RegisterResponse>> loginUser({
    required String email,
    required String password,
  }) async {
    // --- FIX IS HERE ---
    // The API expects 'login', not 'email' as the key.
    final payload = {
      "login": email,
      "password": password
    };
    // -------------------

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