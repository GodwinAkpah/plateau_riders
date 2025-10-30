// lib/services/models/user_model.dart
import 'dart:convert';

class UserModel {
  final int id;
  final String? avatar;
  final String firstname;
  final String lastname;
  final String? middlename;
  final String phone;
  final String email;
  final String gender;

  UserModel({
    required this.id,
    this.avatar,
    required this.firstname,
    required this.lastname,
    this.middlename,
    required this.phone,
    required this.email,
    required this.gender,
  });

  String get fullName => '$firstname $lastname';

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      avatar: map['avatar'],
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      middlename: map['middlename'],
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
    );
  }
}