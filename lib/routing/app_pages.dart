

import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav.dart';
import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav_bindings.dart';
import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_binding/sign_in_screen_bindings.dart';
import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_views/sign_in_screen_views.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.SIGN_IN;
  //  static const initial = Routes.MAINBOTTOMNAV;
 

  static final routes = [
   
    //  GetPage(
    //   name: _Paths.CHOOSELANGUAGESCREEN,
    //   page: () => const ChooseLanguageScreen(),
    //   binding: ChooseLanguageScreenBinding(),
    // ),
  
    //  GetPage(
    //   name: _Paths.VERIFYPHONENUMBER,
    //   page: () => const VerifyPhoneNumberScreen(phoneNumber: '',),
    //   binding: VerifyPhoneNumberBinding(),
    // ),
 

   

      GetPage(
      name: _Paths.SIGN_IN ,
      page: () => const  SignInScreenView(),
      binding: SignInScreenBinding(),
    ),
   

    GetPage(
      name: _Paths.MAINBOTTOMNAV,
      page: () => const MainBottomNav(),
      binding: MainBottomNavBindings(),
    ),
    

    //  GetPage(
    //   name: _Paths.SIGNUP_SCREEN,
    //   page: () => const SignUpScreen(),
    //   binding: SignUpBindings(),
    // ),
    // GetPage(
    //   name: _Paths.PROFILE,
    //   page: () => const ProfileScreen(),
    //   binding: ProfileBinding(),
    // ),

    // --- FIX IS HERE ---
   
  ];
}
