import 'package:dio/dio.dart' as dio_pack;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/models/api_response.dart';

class CoreService extends GetConnect {
  final _dio = dio_pack.Dio();
  final getStorage = GetStorage();

  CoreService() {
    _dio.options.baseUrl = "https://esemunch.gnorizon.com/api/v1";
    setConfig();
  }

  APIResponse _handleDioError(dio_pack.DioException e) {
    if (e.response?.data is Map<String, dynamic>) {
      return APIResponse.fromMap(e.response!.data);
    } else {
      final message =
          e.response?.data is Map
              ? e.response?.data['message']?.toString()
              : "An error occurred.";
      return APIResponse(
        status: "error",
        data: null,
        message: message ?? "Request failed.",
      );
    }
  }

  void setConfig() {
    _dio.interceptors.add(
      dio_pack.InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = getStorage.read('auth_token');
          if (options.data is! dio_pack.FormData) {
            options.headers['Content-Type'] = 'application/json';
          }
          options.headers['Accept'] = 'application/json';
          if (token != null) {
            options.headers['Authorization'] = "Bearer $token";
          }
          return handler.next(options);
        },
        onResponse: (response, handler) => handler.next(response),
        onError: (dio_pack.DioException error, handler) {
          if (error.response?.statusCode == 401 &&
              Get.currentRoute != Routes.SIGN_IN) {
            handleUnauthorizedAccess();
          }
          return handler.next(error);
        },
      ),
    );
  }

  void handleUnauthorizedAccess() {
    getStorage.remove('auth_token');
    Get.offAllNamed(Routes.SIGN_IN);
  }

  Future<APIResponse> send(String url, dynamic payload) async {
    try {
      final res = await _dio.post(url, data: payload);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<APIResponse> update(String url, dynamic data) async {
    try {
      final res = await _dio.put(url, data: data);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<APIResponse> edit(String url, {dynamic data}) async {
    try {
      final res = await _dio.patch(url, data: data);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<APIResponse> fetch(String url, {Map<String, dynamic>? params}) async {
    try {
      final res = await _dio.get(url, queryParameters: params);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<APIResponse> remove(String url, {dynamic data}) async {
    try {
      final res = await _dio.delete(url, data: data);
      return APIResponse.fromMap(res.data);
    } on dio_pack.DioException catch (e) {
      return _handleDioError(e);
    }
  }
}
