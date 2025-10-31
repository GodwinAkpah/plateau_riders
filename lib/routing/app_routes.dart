// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SIGN_IN = _Paths.SIGN_IN;

  
  static const MAINBOTTOMNAV = _Paths.MAINBOTTOMNAV;
  static const TRIP_SELECTION = _Paths.TRIP_SELECTION;
 
  // signin screens
  
}

abstract class _Paths {

  static const SIGN_IN = '/sign_in';
  static const MAINBOTTOMNAV = '/main_bottom_nav';
    static const TRIP_SELECTION = '/trip-selection';

}
