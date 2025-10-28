import 'package:plateau_riders/providers/auth_provider.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthProvider>();
  @override
  RouteSettings? redirect(String? route) {
    return authService.localStorage.hasData('token')
        ? null
        : const RouteSettings(name: Routes.SIGN_IN);
  }
}
