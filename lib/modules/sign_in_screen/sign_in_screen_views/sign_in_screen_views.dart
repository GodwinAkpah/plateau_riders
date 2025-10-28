
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_controller/sign_in_screen_controllers.dart';

class SignInScreenView extends GetView<SignInScreenController> {
  const SignInScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInScreenController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Access your trips, tickets, and booking history anytime',
                    style: GoogleFonts.urbanist(
                      color: Color(0xFF8A8A8A),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Phone Number / Email',
                    style: GoogleFonts.urbanist(
                      color: Color(0xFF8A8A8A),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.emailPhoneController,
                    focusNode: controller.emailPhoneFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Phone Number / Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number or email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Password',
                    style: GoogleFonts.urbanist(
                      color: Color(0xFF8A8A8A),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    obscureText: controller.obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: 'By signing up you agree to our ',
                      style: GoogleFonts.urbanist(
                        color: Color(0xFF8A8A8A),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Handle terms and conditions tap
                          },
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            // Handle privacy policy tap
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF009300), Color(0xFF022102)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: controller.isLoading ? 0.0 : 1.0,
                            child: Text(
                              'Continue',
                              style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: controller.isLoading ? 1.0 : 0.0,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: controller.isLoading ? null : controller.performSignIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.urbanist(
                          color: Color(0xFF8A8A8A),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.3,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.navigateToCreateAccount,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
