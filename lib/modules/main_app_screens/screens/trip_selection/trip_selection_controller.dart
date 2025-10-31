import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/services/models/trip_model.dart';


class TripSelectionController extends GetxController {
  // --- STATE ---
  // These variables will hold the data passed from the HomeController.
  var availableTrips = <TripModel>[].obs;
  var originName = ''.obs;
  var destinationName = ''.obs;
  var tripDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the arguments passed from the previous screen.
    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments;
      availableTrips.assignAll(args['trips'] as List<TripModel>);
      originName.value = args['originName'] as String;
      destinationName.value = args['destinationName'] as String;
      
      // Format the date for display
      final DateTime parsedDate = DateTime.parse(args['date']);
      tripDate.value = DateFormat('dd-MM-yyyy').format(parsedDate);
    }
  }

  // --- ACTIONS ---
  /// Formats the time string (e.g., "14:30:00") into a readable format (e.g., "02:30 PM").
  String formatTime(String time) {
    try {
      final parsedTime = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('hh:mm a').format(parsedTime);
    } catch (e) {
      return time; // Return original time if formatting fails
    }
  }

  /// Formats the amount string into a currency format.
  String formatCurrency(String amount) {
    try {
      final number = double.parse(amount);
      // Ensure you have the intl package added to your pubspec.yaml
      final format = NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2);
      return format.format(number);
    } catch (e) {
      return amount; // Return original amount if formatting fails
    }
  }

  /// This method will be called when a user taps the "View" button.
  // void selectTrip(TripModel trip) {
  //   // For now, it just shows a snackbar.
  //   // NEXT STEP: This will navigate to the Passenger Details screen.
  //   Get.snackbar(
  //     'Trip Selected',
  //     'Vehicle: ${trip.vehicle.name} at ${formatTime(trip.time)}',
  //     snackPosition: SnackPosition.BOTTOM,
  //   );
  //   print('Selected Trip ID: ${trip.id}');
  // }
    void selectTrip(TripModel trip) {
    // --- FIX START ---
    // Safely get the vehicle name. If trip.vehicle is null, provide a fallback string.
    final vehicleName = trip.vehicle?.name ?? 'Unassigned Vehicle';
    // --- FIX END ---

    // For now, it just shows a snackbar.
    // NEXT STEP: This will navigate to the Passenger Details screen.
    Get.snackbar(
      'Trip Selected',
      'Vehicle: $vehicleName at ${formatTime(trip.time)}', // Use the safe variable
      snackPosition: SnackPosition.BOTTOM,
    );
    print('Selected Trip ID: ${trip.id}');
  }
}