// // lib/services/models/register_response.dart

// import 'dart:convert';

// // Helper function to parse the JSON string
// RegisterResponse registerResponseFromMap(String str) => RegisterResponse.fromMap(json.decode(str));

// // Main Response Class
// class RegisterResponse {
//     final String status;
//     final String message;
//     final RegisterData? data;
//     final String timestamp;

//     RegisterResponse({
//         required this.status,
//         required this.message,
//         this.data,
//         required this.timestamp,
//     });

//     factory RegisterResponse.fromMap(Map<String, dynamic> json) => RegisterResponse(
//         status: json["status"],
//         message: json["message"],
//         data: json["data"] == null ? null : RegisterData.fromMap(json["data"]),
//         timestamp: json["timestamp"],
//     );
// }

// // The 'data' object containing the user and token
// class RegisterData {
//     final UserData user;
//     final String authToken; // Matches "auth_token" from your API

//     RegisterData({
//         required this.user,
//         required this.authToken,
//     });

//     factory RegisterData.fromMap(Map<String, dynamic> json) => RegisterData(
//         user: UserData.fromMap(json["user"]),
//         authToken: json["auth_token"],
//     );
// }

// // The 'user' object inside 'data'
// class UserData {
//     final String fname;
//     final String lname;
//     final String phone;
//     final String email;
//     final DateTime updatedAt;
//     final DateTime createdAt;
//     final int id;

//     UserData({
//         required this.fname,
//         required this.lname,
//         required this.phone,
//         required this.email,
//         required this.updatedAt,
//         required this.createdAt,
//         required this.id,
//     });

//     factory UserData.fromMap(Map<String, dynamic> json) => UserData(
//         fname: json["fname"],
//         lname: json["lname"],
//         phone: json["phone"],
//         email: json["email"],
//         updatedAt: DateTime.parse(json["updated_at"]),
//         createdAt: DateTime.parse(json["created_at"]),
//         id: json["id"],
//     );
// }


import 'package:plateau_riders/services/models/user_model.dart';

/// This model specifically represents the data structure returned
/// by your API upon a successful login or registration.
class RegisterResponse {
  final UserModel user;
  final String authToken;

  RegisterResponse({
    required this.user,
    required this.authToken,
  });

  /// Factory constructor to create a `RegisterResponse` from a map (JSON object).
  /// This is where the raw API data is parsed into our clean model.
  factory RegisterResponse.fromMap(Map<String, dynamic> map) {
    // The login API response likely has a structure like:
    // { "token": "...", "user": { ... } }
    // This factory correctly pulls data from those keys.
    return RegisterResponse(
      // Pass the nested user map to the UserModel's own fromMap factory
      user: UserModel.fromMap(map['user'] ?? {}),
      
      // Get the token. It might be under the key 'token' or 'auth_token'.
      authToken: map['token'] ?? map['auth_token'] ?? '',
    );
  }
}