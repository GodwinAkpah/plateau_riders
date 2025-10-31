import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/models/trip_model.dart';

import 'package:plateau_riders/services/models/vehicle_model.dart';


class TripSelectionController extends GetxController {
  // --- STATE ---
  var allAvailableTrips = <TripModel>[].obs;
  var originName = ''.obs;
  var destinationName = ''.obs;
  var tripDate = ''.obs;
  var numberOfSeats = 1.obs;

  // --- FILTERING STATE ---
  var selectedVehicleId = Rxn<int>(); // The ID of the vehicle currently being filtered

  // --- COMPUTED PROPERTIES (These update automatically!) ---
  
  /// A computed list of unique vehicles derived from all available trips.
  List<VehicleModel> get uniqueVehicles {
    if (allAvailableTrips.isEmpty) return [];
    final seenIds = <int>{};
    // Use where to filter out duplicates based on vehicle ID
    return allAvailableTrips
        .where((trip) => trip.vehicle != null && seenIds.add(trip.vehicle!.id))
        .map((trip) => trip.vehicle!)
        .toList();
  }

  /// A computed list that shows only the trips matching the selected vehicle filter.
  List<TripModel> get filteredTrips {
    if (selectedVehicleId.value == null) {
      return allAvailableTrips; // If no filter, show all
    }
    return allAvailableTrips.where((trip) => trip.vehicle?.id == selectedVehicleId.value).toList();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      final Map<String, dynamic> args = Get.arguments;
      allAvailableTrips.assignAll(args['trips'] as List<TripModel>);
      originName.value = args['originName'] as String;
      destinationName.value = args['destinationName'] as String;
      numberOfSeats.value = args['numberOfSeats'] as int;
      
      final DateTime parsedDate = DateTime.parse(args['date']);
      tripDate.value = DateFormat('dd-MM-yyyy').format(parsedDate);

      // Set the initial filter based on the vehicle selected on the home screen
      final String initialVehicleName = args['selectedVehicleName'];
      final initialVehicle = uniqueVehicles.firstWhereOrNull(
        (v) => v.name == initialVehicleName,
      );
      // If found, set its ID as the active filter. Otherwise, filter by the first available vehicle.
      if (initialVehicle != null) {
        selectedVehicleId.value = initialVehicle.id;
      } else if (uniqueVehicles.isNotEmpty) {
        selectedVehicleId.value = uniqueVehicles.first.id;
      }
    }
  }

  // --- ACTIONS ---

  /// Updates the active filter when a user taps on a vehicle chip.
  void setVehicleFilter(int vehicleId) {
    selectedVehicleId.value = vehicleId;
  }

  String formatTime(String time) {
    try {
      return DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(time));
    } catch (e) {
      return time;
    }
  }

  String formatCurrency(String amount) {
    try {
      final number = double.parse(amount);
      return NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2).format(number);
    } catch (e) {
      return amount;
    }
  }

  /// Navigates to the passenger details screen.
  void selectTrip(TripModel trip) {
    Get.toNamed(
      Routes.PASSENGER_DETAILS,
      arguments: {
        'trip': trip,
        'numberOfSeats': numberOfSeats.value,
      },
    );
  }
}