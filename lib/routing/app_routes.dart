part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SIGN_IN = _Paths.SIGN_IN;
  static const MAINBOTTOMNAV = _Paths.MAINBOTTOMNAV;
  static const HOME = _Paths.HOME;
  static const TRIP_SELECTION = _Paths.TRIP_SELECTION;
  static const SELECT_SEAT = _Paths.SELECT_SEAT;
  static const PASSENGER_DETAILS = _Paths.PASSENGER_DETAILS;
  static const CONFIRM_BOOKING = _Paths.CONFIRM_BOOKING;
  static const MAKE_PAYMENT = _Paths.MAKE_PAYMENT;
}

abstract class _Paths {
  _Paths._();
  static const SIGN_IN = '/sign-in';
  static const MAINBOTTOMNAV = '/main-bottom-nav';
  static const HOME = '/home';
  static const TRIP_SELECTION = '/trip-selection';
  static const SELECT_SEAT = '/select-seat';
  static const PASSENGER_DETAILS = '/passenger-details';
  static const CONFIRM_BOOKING = '/confirm-booking';
  static const MAKE_PAYMENT = '/make-payment';
}