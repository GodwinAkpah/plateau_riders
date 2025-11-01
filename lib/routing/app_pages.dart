

// import 'package:get/get.dart';
// import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav.dart';
// import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav_bindings.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_binding.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_view.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_binding.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_view.dart';
// import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_binding/sign_in_screen_bindings.dart';
// import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_views/sign_in_screen_views.dart';


// part 'app_routes.dart';

// class AppPages {
//   AppPages._();

//   static const initial = Routes.SIGN_IN;
//   //  static const initial = Routes.MAINBOTTOMNAV;
 

//   static final routes = [
   
//     //  GetPage(
//     //   name: _Paths.CHOOSELANGUAGESCREEN,
//     //   page: () => const ChooseLanguageScreen(),
//     //   binding: ChooseLanguageScreenBinding(),
//     // ),
  
//     //  GetPage(
//     //   name: _Paths.VERIFYPHONENUMBER,
//     //   page: () => const VerifyPhoneNumberScreen(phoneNumber: '',),
//     //   binding: VerifyPhoneNumberBinding(),
//     // ),
 

   

//       GetPage(
//       name: _Paths.SIGN_IN ,
//       page: () => const  SignInScreenView(),
//       binding: SignInScreenBinding(),
//     ),
   

//     GetPage(
//       name: _Paths.MAINBOTTOMNAV,
//       page: () => const MainBottomNav(),
//       binding: MainBottomNavBindings(),
//     ),
    
//     GetPage(
//       name: _Paths.TRIP_SELECTION,
//       page: () => const TripSelectionView(),
//       binding: TripSelectionBinding(),
//       transition: Transition.rightToLeft, // Optional: Add a nice transition
//     ),
//       GetPage(
//       name: _Paths.PASSENGER_DETAILS,
//       page: () => const PassengerDetailsView(),
//       binding: PassengerDetailsBinding(),
//     ),
//     //  GetPage(
//     //   name: _Paths.SIGNUP_SCREEN,
//     //   page: () => const SignUpScreen(),
//     //   binding: SignUpBindings(),
//     // ),
//     // GetPage(
//     //   name: _Paths.PROFILE,
//     //   page: () => const ProfileScreen(),
//     //   binding: ProfileBinding(),
//     // ),

//     // --- FIX IS HERE ---
   
//   ];
// }

import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav.dart';
import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav_bindings.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/confirm_booking/confirm_booking_binding.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/confirm_booking/confirm_booking_view.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/make_payment/make_payment_binding.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/make_payment/make_payment_view.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_binding.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/passenger_details/passenger_details_view.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/select_seat/select_seat_binding.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/select_seat/select_seat_view.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_binding.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_view.dart';
import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_binding/sign_in_screen_bindings.dart';
import 'package:plateau_riders/modules/sign_in_screen/sign_in_screen_views/sign_in_screen_views.dart';
// ... other existing imports ...

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.SIGN_IN;

  static final routes = [

   
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
    
    GetPage(
      name: _Paths.TRIP_SELECTION,
      page: () => const TripSelectionView(),
      binding: TripSelectionBinding(),
      transition: Transition.rightToLeft, // Optional: Add a nice transition
    ),
      GetPage(
      name: _Paths.PASSENGER_DETAILS,
      page: () => const PassengerDetailsView(),
      binding: PassengerDetailsBinding(),
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



    // ... existing routes ...
    GetPage(
      name: _Paths.TRIP_SELECTION,
      page: () => const TripSelectionView(),
      binding: TripSelectionBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_SEAT,
      page: () => const SelectSeatView(),
      binding: SelectSeatBinding(),
    ),
    GetPage(
      name: _Paths.PASSENGER_DETAILS,
      page: () => const PassengerDetailsView(),
      binding: PassengerDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CONFIRM_BOOKING,
      page: () => const ConfirmBookingView(),
      binding: ConfirmBookingBinding(),
    ),
    GetPage(
      name: _Paths.MAKE_PAYMENT,
      page: () => const MakePaymentView(),
      binding: MakePaymentBinding(),
    ),
  ];
}
