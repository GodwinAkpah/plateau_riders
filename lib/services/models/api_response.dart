// lib/services/models/api_response.dart
import 'dart:convert';

class APIResponse {
  String status;
  String message;
  dynamic data; // Keep as dynamic to hold the actual data object
  APIResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status, // Changed 'success' to 'status' to match API
      'message': message,
      'data': data,
    };
  }

  factory APIResponse.fromMap(Map<String, dynamic> map) {
    return APIResponse(
      status: map['status'] ?? "error", // Default to "error" if status is missing
      message: map['message'] ?? map['error'] ?? "An unknown error occurred.",
      data: map['data'], // Directly assign map['data'] which can be null or an object
    );
  }

  String toJson() => json.encode(toMap());

  factory APIResponse.fromJson(String source) =>
      APIResponse.fromMap(json.decode(source));
}