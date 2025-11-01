
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plateau_riders/routing/app_pages.dart';
// import 'package:plateau_riders/services/models/trip_model.dart';

// class SelectSeatController extends GetxController {
//   late TripModel trip;
//   late int seatsToSelectCount;

//   // --- STATE ---
//   // A complete list of all seat numbers for this vehicle (e.g., 1 to 14)
//   var allSeatNumbers = <int>[].obs;
//   // A Set of seats that are already booked
//   var bookedSeats = <int>{}.obs;
//   // A list of seats the user has tapped and selected in the UI
//   var selectedSeats = <int>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final args = Get.arguments as Map<String, dynamic>;
//     trip = args['trip'];
//     seatsToSelectCount = args['numberOfSeats'];
    
//     // --- THIS IS THE CORRECTED LOGIC ---
//     if (trip.vehicle != null && trip.vehicle!.capacity > 0) {
//       final int capacity = trip.vehicle!.capacity;

//       // 1. Create a set of all possible seat numbers from 1 to capacity.
//       final Set<int> allPossibleSeats = List.generate(capacity, (i) => i + 1).toSet();
//       allSeatNumbers.value = allPossibleSeats.toList(); // For building the GridView

//       // 2. Create a set of the seats that the API told us are available.
//       final Set<int> availableSeatSet = trip.availableSeats.toSet();

//       // 3. Calculate the booked seats: Booked = All - Available.
//       final Set<int> calculatedBookedSeats = allPossibleSeats.difference(availableSeatSet);
//       bookedSeats.value = calculatedBookedSeats;

//     } else {
//       // Handle the error case where vehicle data is missing or invalid
//       allSeatNumbers.value = [];
//       bookedSeats.value = {};
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Get.snackbar(
//           'Error', 'Could not load seat map. Vehicle data is invalid.',
//           backgroundColor: Colors.red, colorText: Colors.white
//         );
//       });
//     }
//     // --- END OF CORRECTED LOGIC ---
//   }

//   void toggleSeatSelection(int seatNumber) {
//     // Prevent interaction with already booked seats
//     if (bookedSeats.contains(seatNumber)) return;

//     if (selectedSeats.contains(seatNumber)) {
//       selectedSeats.remove(seatNumber); // Unselect
//     } else {
//       if (selectedSeats.length < seatsToSelectCount) {
//         selectedSeats.add(seatNumber); // Select
//       } else {
//         Get.snackbar(
//           'Limit Reached',
//           'You can only select $seatsToSelectCount seat(s).',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     }
//   }

//   void proceedToPassengerDetails() {
//     if (selectedSeats.length != seatsToSelectCount) {
//       Get.snackbar('Selection Incomplete', 'Please select exactly $seatsToSelectCount seat(s).');
//       return;
//     }
//     selectedSeats.sort();
//     Get.toNamed(Routes.PASSENGER_DETAILS, arguments: {
//       'trip': trip,
//       'selectedSeats': selectedSeats.toList(),
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/models/trip_model.dart';

class SelectSeatController extends GetxController {
  late TripModel trip;
  late int seatsToSelectCount;

  // --- STATE ---
  // A complete list of all seat numbers for this vehicle (e.g., 1 to 14)
  var allSeatNumbers = <int>[].obs;
  // A Set of seats that are already booked
  var bookedSeats = <int>{}.obs;
  // A list of seats the user has tapped and selected in the UI
  var selectedSeats = <int>[].obs;

  @override
   @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    trip = args['trip'];
    seatsToSelectCount = args['numberOfSeats'];
    
    // --- THIS IS THE CORRECTED LOGIC ---
    
    // 1. Use the capacity directly from the Trip object. This is the source of truth.
    final int tripCapacity = trip.capacity;
    print('[DEBUG] Trip Capacity from API: $tripCapacity');

    if (tripCapacity > 0) {
      // 2. Create a set of all possible seat numbers for THIS trip (1 to tripCapacity).
      final Set<int> allPossibleSeats = List.generate(tripCapacity, (i) => i + 1).toSet();
      allSeatNumbers.value = allPossibleSeats.toList();

      // 3. Create a set of the seats that the API told us are available for THIS trip.
      final Set<int> availableSeatSet = trip.availableSeats.toSet();

      // 4. Calculate the booked seats: Booked = All (for this trip) - Available.
      final Set<int> calculatedBookedSeats = allPossibleSeats.difference(availableSeatSet);
      bookedSeats.value = calculatedBookedSeats;

      print('[DEBUG] Generated ${allSeatNumbers.length} seat boxes.');
      print('[DEBUG] Available Seats: ${availableSeatSet.length}');
      print('[DEBUG] Calculated Booked Seats: ${calculatedBookedSeats.length}');

    } else {
      // Handle the error case where trip capacity is invalid
      allSeatNumbers.value = [];
      bookedSeats.value = {};
      print('[FATAL ERROR] Invalid trip capacity received: $tripCapacity.');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          'Error', 'Could not load seat map. Trip data is invalid.',
          backgroundColor: Colors.red, colorText: Colors.white
        );
      });
    }
    // --- END OF CORRECTED LOGIC ---
  }

  void toggleSeatSelection(int seatNumber) {
    // Prevent interaction with already booked seats
    if (bookedSeats.contains(seatNumber)) return;

    if (selectedSeats.contains(seatNumber)) {
      selectedSeats.remove(seatNumber); // Unselect
    } else {
      if (selectedSeats.length < seatsToSelectCount) {
        selectedSeats.add(seatNumber); // Select
      } else {
        Get.snackbar(
          'Limit Reached',
          'You can only select $seatsToSelectCount seat(s).',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  void proceedToPassengerDetails() {
    if (selectedSeats.length != seatsToSelectCount) {
      Get.snackbar('Selection Incomplete', 'Please select exactly $seatsToSelectCount seat(s).');
      return;
    }
    selectedSeats.sort();
    Get.toNamed(Routes.PASSENGER_DETAILS, arguments: {
      'trip': trip,
      'selectedSeats': selectedSeats.toList(),
    });
  }
}