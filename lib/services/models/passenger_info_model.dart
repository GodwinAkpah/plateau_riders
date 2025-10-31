import 'package:flutter/material.dart';

// A simple data class to hold the form data for one passenger.
class PassengerInfo {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController nokNameController;
  final TextEditingController nokPhoneController;
  String? selectedGender;

  PassengerInfo()
      : formKey = GlobalKey<FormState>(),
        nameController = TextEditingController(),
        emailController = TextEditingController(),
        phoneController = TextEditingController(),
        nokNameController = TextEditingController(),
        nokPhoneController = TextEditingController();

  // Method to dispose all controllers to prevent memory leaks
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nokNameController.dispose();
    nokPhoneController.dispose();
  }
}