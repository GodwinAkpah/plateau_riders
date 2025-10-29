// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SIGN_IN = _Paths.SIGN_IN;

  
  static const MAINBOTTOMNAV = _Paths.MAINBOTTOMNAV;
 
  // signin screens
  
}

abstract class _Paths {

  static const SIGN_IN = '/sign_in';
  static const MAINBOTTOMNAV = '/main_bottom_nav';

}
