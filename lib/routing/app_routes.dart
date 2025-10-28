// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const SIGN_IN = _Paths.SIGN_IN;

  static const CHOOSELANGUAGESCREEN = _Paths.CHOOSELANGUAGESCREEN;
  static const CREATEACCOUNTSCREEN = _Paths.CREATEACCOUNTSCREEN;
  static const VERIFYPHONENUMBER = _Paths.VERIFYPHONENUMBER;
  static const SELECTUSERTYPESCREEN = _Paths.SELECTUSERTYPESCREEN;
  static const SELECTSERVICESSCREEN = _Paths.SELECTSERVICESSCREEN;
  static const LOCATIONACCESSSCREEN = _Paths.LOCATIONACCESSSCREEN;
  static const SETPASSWORDSCREEN = _Paths.SETPASSWORDSCREEN;
  static const MAINBOTTOMNAV = _Paths.MAINBOTTOMNAV;
  static const FILTERRESULTSCREEN = _Paths.FILTERRESULTSCREEN;
  static const RESETPASSWORDSCREEN = _Paths.RESETPASSWORDSCREEN;
  // signin screens
  static const PROFILE = _Paths.PROFILE;
  static const EDITPROFILE = _Paths.EDITPROFILE;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;

  static const VENDOR_DETAIL = _Paths.VENDOR_DETAIL;

  static const ALL_VENDORS = _Paths.ALL_VENDORS;
  static const MY_VENDORS = _Paths.MY_VENDORS;
}

abstract class _Paths {
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const SIGN_IN = '/sign_in';
  static const CHOOSELANGUAGESCREEN = '/sign_inCHOOSELANGUAGESCREEN';
  static const CREATEACCOUNTSCREEN = '/create_account_screen';
  static const VERIFYPHONENUMBER = '/verify_phone_number';
  static const SELECTUSERTYPESCREEN = '/SelectUserTypeScreen';
  static const SELECTSERVICESSCREEN = '/SelectServicesScreen';
  static const LOCATIONACCESSSCREEN = '/location_access_screen';
  static const SETPASSWORDSCREEN = '/set_password_screen';
  static const MAINBOTTOMNAV = '/main_bottom_nav';
  static const FILTERRESULTSCREEN = '/filter_result_screen';
  static const RESETPASSWORDSCREEN = '/reset_password_screen';

  static const PROFILE = '/profile';
  static const EDITPROFILE = '/profile/edit';
  static const NOTIFICATIONS = '/profile/notifications';

  static const VENDOR_DETAIL = '/vendor/:vendorId';
  static const ALL_VENDORS = '/vendors';
  static const MY_VENDORS = '/profile/my-vendors';
}
