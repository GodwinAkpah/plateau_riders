import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:plateau_riders/services/core_service.dart';
import 'package:plateau_riders/services/models/api_response.dart';

class AuthenticationService extends CoreService {
  // --- REGISTRATION & LOGIN ---
  Future<APIResponse> signup(dynamic data) async =>
      await send("/customers/register", data);
  // await send("/auth/register", data);
  Future<APIResponse> login(dynamic data) async =>
      await send("/auth/login", data);
  Future<APIResponse> logout() async => await send("/auth/logout", {});

  // --- PASSWORD MANAGEMENT ---
  Future<APIResponse> setPassword(dynamic data) async =>
      await update("/customers/set-password", data);
  // await send("/auth/set-password", data);
  Future<APIResponse> changePassword(dynamic data) async =>
      await update("/customers/change-password", data);
  // await update("/auth/change-password", data);
  Future<APIResponse> resetPassword(dynamic data) async =>
      await update("/customers/reset-password", data);
  // await update("/auth/reset-password", data);

  // --- VERIFICATION & OTP ---
  Future<APIResponse> sendOtp(dynamic data) async =>
      await fetch("/customer/get-otp?login=${data['login']}");
  Future<APIResponse> verifyPhoneOtp(dynamic data) async =>
      await send("/customer/verify-phone", data);
  Future<APIResponse> verifyEmailOtp(dynamic data) async =>
      await send("/customers/verify-email", data);

  // --- USER PROFILE ---
  Future<APIResponse> getMe() async => await fetch("/customer/me");

  // --- THIS IS THE ONLY 'updateMe' METHOD YOU NEED ---
  Future<APIResponse> updateMe(Map<String, dynamic> data) async {
    // 1. Create a FormData object. This is the container for multipart requests.
    final formData = dio.FormData();

    // 2. Loop through the data map from the controller.
    for (var entry in data.entries) {
      if (entry.value is File) {
        // If the value is a File, add it to the FormData's 'files' list.
        formData.files.add(
          MapEntry(
            entry.key, // The key e.g., 'avatar'
            await dio.MultipartFile.fromFile(entry.value.path),
          ),
        );
      } else if (entry.value != null) {
        // If it's a regular value (String, int), add it to the 'fields' list.
        formData.fields.add(MapEntry(entry.key, entry.value.toString()));
      }
    }

    // 3. Call the generic 'send' method from CoreService with the FormData payload.
    // We use 'send' because the server endpoint for updating the profile is POST /me.
    return await send("/customer/me", formData);
  }

  /// Fetches the list of notifications for the logged-in user.
  Future<APIResponse> getNotifications() async {
    return await fetch("/notifications");
  }

  // REPORT
  Future<APIResponse> reportVendor(dynamic data) async =>
      await send("/reports", data);
}
