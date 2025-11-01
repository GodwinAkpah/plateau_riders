import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/models/passenger_info_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';


class ConfirmBookingController extends GetxController {
  late TripModel trip;
  late List<PassengerInfo> passengers;
  late List<int> selectedSeats;

  // Formatted data for the view
  late String passengerNames;
  late String totalAmount;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    trip = args['trip'];
    passengers = args['passengers'];
    selectedSeats = args['selectedSeats'];

    // Prepare data for easy display
    passengerNames = passengers.map((p) => p.nameController.text).join(', ');
    
    final amount = double.tryParse(trip.amount) ?? 0.0;
    final total = amount * selectedSeats.length;
    totalAmount = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2).format(total);
  }

  void proceedToPayment() {
    Get.toNamed(Routes.MAKE_PAYMENT, arguments: Get.arguments);
  }
}