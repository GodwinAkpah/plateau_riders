// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plateau_riders/routing/app_pages.dart';
// import 'package:plateau_riders/services/auth/authentication_service.dart';
// import 'package:plateau_riders/services/booking_service.dart';
// import 'package:plateau_riders/services/models/terminal_model.dart';
// import 'package:plateau_riders/services/models/trip_model.dart';
// import 'package:plateau_riders/services/models/user_model.dart';
// import 'package:plateau_riders/services/models/vehicle_model.dart';



// class HomeController extends GetxController {
//   // --- SERVICES ---
//   // Lazily finds the registered services. Ensure they are registered in your service locator (e.g., in main.dart).
//   final AuthenticationService _authService = Get.find<AuthenticationService>();
//   final BookingService _bookingService = Get.find<BookingService>();

//   // --- UI STATE ---
//   // These are observable variables that the UI will listen to for changes.
//   var isOneWay = true.obs;
//   var fromCity = 'Select City'.obs;
//   var toCity = 'Select City'.obs;
//   var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
//   var selectedVehicleType = 'Select Vehicle'.obs;
//   var numberOfSeats = 1.obs;

//   // --- DATA STATE ---
//   // These lists will be populated from the API.
//   var terminals = <TerminalModel>[].obs;
//   var vehicles = <VehicleModel>[].obs;
//   var availableTrips = <TripModel>[].obs;

//   // --- CONTROL STATE ---
//   // Used to show loading indicators in the UI.
//   var isLoading = false.obs; // For initial data loading
//   var isSearchingTrips = false.obs; // For the 'Continue' button action

//   // --- USER STATE ---
//   // A clean getter to access the current user from the AuthenticationService.
//   // The UI can observe this directly.
//   Rx<UserModel?> get currentUser => _authService.currentUser;

//   @override
//   void onInit() {
//     super.onInit();
//     // Fetch all necessary data when the home screen is first loaded.
//     fetchInitialData();
//   }

//   // --- CORE ACTIONS ---

//   /// Logs the user out by calling the authentication service.
//   void logout() {
//     _authService.logout();
//   }

//   /// Toggles the trip type between 'One Way' and 'Round Trip'.
//   void toggleTripType(bool oneWay) {
//     isOneWay.value = oneWay;
//   }

//   /// Increments the number of seats to be booked.
//   void incrementSeats() {
//     numberOfSeats.value++;
//   }

//   /// Decrements the number of seats, with a minimum of 1.
//   void decrementSeats() {
//     if (numberOfSeats.value > 1) {
//       numberOfSeats.value--;
//     }
//   }

//   // --- DATA FETCHING METHODS ---

//   /// Fetches the user's profile, all terminals, and all vehicles concurrently for a faster UI load.
//   Future<void> fetchInitialData() async {
//     isLoading.value = true;
//     // `Future.wait` runs all async calls at the same time and waits for all to complete.
//     await Future.wait([
//       _authService.getUserProfile(),
//       fetchTerminals(),
//       fetchVehicles(), 
//     ]);
//     isLoading.value = false;
//   }

//   /// Fetches the list of terminals from the API.
//   Future<void> fetchTerminals({String? search}) async {
//     final response = await _bookingService.getTerminals(search: search);
//     if (response.status == "success" && response.data != null) {
//       terminals.assignAll(response.data!);
//     } else {
//       Get.snackbar("Error Loading Terminals", response.message,
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   /// Fetches the list of vehicles from the API.
//   Future<void> fetchVehicles() async {
//     final response = await _bookingService.getVehicles();
//     if (response.status == "success" && response.data != null) {
//       vehicles.assignAll(response.data!);
//     } else {
//       Get.snackbar("Error Loading Vehicles", response.message,
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

  
//     Future<void> searchTripsForBooking() async {
//     if (fromCity.value == 'Select City' || toCity.value == 'Select City') {
//       Get.snackbar("Input Required", "Please select origin and destination.",
//           backgroundColor: Colors.orange, colorText: Colors.white);
//       return;
//     }

//     final originTerminal = terminals.firstWhereOrNull((t) => t.name == fromCity.value);
//     final destinationTerminal = terminals.firstWhereOrNull((t) => t.name == toCity.value);

//     if (originTerminal == null || destinationTerminal == null) {
//       Get.snackbar("Error", "Selected city is invalid.",
//           backgroundColor: Colors.red, colorText: Colors.white);
//       return;
//     }
    
//     final parsedDate = DateFormat('dd-MM-yyyy').parse(selectedDate.value);
//     final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

//     isSearchingTrips.value = true;
//     final response = await _bookingService.searchTrips(
//       date: formattedDate,
//       originId: originTerminal.id,
//       destinationId: destinationTerminal.id,
//     );
//     isSearchingTrips.value = false;

//     if (response.status == "success" && response.data != null) {
//       final List<TripModel> fetchedTrips = response.data!;
//       availableTrips.assignAll(fetchedTrips);
      
//       Get.toNamed(
//         Routes.TRIP_SELECTION,
//         arguments: {
//           'trips': fetchedTrips,
//           'originName': originTerminal.name,
//           'destinationName': destinationTerminal.name,
//           'date': formattedDate,
//           // --- NEW DATA BEING PASSED ---
//           'selectedVehicleName': selectedVehicleType.value,
//           'numberOfSeats': numberOfSeats.value,
//           // ---------------------------
//         },
//       );
//     } else {
//       Get.snackbar("Trip Search Failed", response.message,
//           backgroundColor: Colors.red, colorText: Colors.white);
//     }
//   }

//   // --- UI HELPER METHODS (BOTTOM SHEETS & PICKERS) ---

//     Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
//     print('[DEBUG] showCitySelectionBottomSheet called.');
    
//     // Ensure terminals are loaded before showing the sheet
//     if (terminals.isEmpty) {
//       print('[DEBUG] Terminals list is empty. Calling fetchTerminals()...');
//       await fetchTerminals();
//       print('[DEBUG] fetchTerminals() finished. Current terminals count: ${terminals.length}');
//     } else {
//       print('[DEBUG] Terminals list already has ${terminals.length} items. Not fetching again.');
//     }

//     if (terminals.isNotEmpty) {
//        print('[DEBUG] Showing bottom sheet with ${terminals.length} items.');
//     } else {
//        print('[ERROR] Terminals list is still empty. The bottom sheet will be empty.');
//     }

//     final selectedTerminal = await Get.bottomSheet<TerminalModel>(
//       _buildSelectionSheet<TerminalModel>(
//         title: 'Select City',
//         items: terminals,
//         itemBuilder: (terminal) => Text(
//           terminal.name,
//           style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//     );

//     if (selectedTerminal != null) {
//       print('[DEBUG] User selected terminal: ${selectedTerminal.name}');
//       if (isFrom) {
//         fromCity.value = selectedTerminal.name;
//       } else {
//         toCity.value = selectedTerminal.name;
//       }
//     } else {
//       print('[DEBUG] User closed the bottom sheet without selecting.');
//     }
//   }

//   /// Shows a bottom sheet for selecting a 'From' or 'To' city.
//   // Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
//   //   // Ensure terminals are loaded before showing the sheet
//   //   if (terminals.isEmpty) await fetchTerminals();

//   //   final selectedTerminal = await Get.bottomSheet<TerminalModel>(
//   //     _buildSelectionSheet<TerminalModel>(
//   //       title: 'Select City',
//   //       items: terminals,
//   //       itemBuilder: (terminal) => Text(
//   //         terminal.name,
//   //         style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
//   //       ),
//   //     ),
//   //     backgroundColor: Colors.transparent,
//   //     isScrollControlled: true,
//   //   );

//   //   if (selectedTerminal != null) {
//   //     if (isFrom) {
//   //       fromCity.value = selectedTerminal.name;
//   //     } else {
//   //       toCity.value = selectedTerminal.name;
//   //     }
//   //   }
//   // }

//   /// Shows a bottom sheet for selecting a vehicle.
//   Future<void> showVehicleTypeSelectionBottomSheet() async {
//     // Ensure vehicles are loaded
//     if (vehicles.isEmpty) await fetchVehicles();

//     final selectedVehicle = await Get.bottomSheet<VehicleModel>(
//       _buildSelectionSheet<VehicleModel>(
//         title: 'Select Vehicle',
//         items: vehicles,
//         itemBuilder: (vehicle) => Text(
//           vehicle.name, // Displaying the vehicle's name (e.g., "Toyota Hiace")
//           style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//     );

//     if (selectedVehicle != null) {
//       selectedVehicleType.value = selectedVehicle.name;
//     }
//   }

//   /// Shows the device's native date picker.
//   /// This method is correctly named to avoid conflicts with Flutter's built-in `showDatePicker`.
//   Future<void> openDatePicker() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: Get.context!,
//       initialDate: DateFormat('dd-MM-yyyy').parse(selectedDate.value),
//       firstDate: DateTime.now().subtract(const Duration(days: 30)),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );

//     if (pickedDate != null) {
//       selectedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
//     }
//   }

//   /// A generic, reusable widget builder for creating a selection bottom sheet.
//   /// This reduces code duplication for city and vehicle selection.
//   Widget _buildSelectionSheet<T>({
//     required String title,
//     required List<T> items,
//     required Widget Function(T item) itemBuilder,
//   }) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               margin: const EdgeInsets.only(top: 10, bottom: 20),
//               height: 4,
//               width: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Text(
//               title,
//               style: GoogleFonts.urbanist(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 15),
//           Flexible(
//             child: ListView.separated(
//               shrinkWrap: true,
//               itemCount: items.length,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return ListTile(
//                   title: itemBuilder(item),
//                   onTap: () => Get.back(result: item),
//                 );
//               },
//               separatorBuilder: (context, index) =>
//                   Divider(height: 1, color: Colors.grey[200], indent: 20, endIndent: 20),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/auth/authentication_service.dart';

import 'package:plateau_riders/services/booking_service.dart';
import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';
import 'package:plateau_riders/services/models/user_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeController extends GetxController {
  final AuthenticationService _authService = Get.find<AuthenticationService>();
  final BookingService _bookingService = Get.find<BookingService>();

  // --- UI STATE ---
  var isOneWay = true.obs;
  var fromCity = 'Select City'.obs;
  var toCity = 'Select City'.obs;
  var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  var returnDate = 'Select Return Date'.obs; // For Round Trip
  var selectedVehicleType = 'Select Vehicle'.obs;
  var numberOfSeats = 1.obs;

  // --- FORM VALIDITY & CONTROL STATE ---
  var isFormValid = false.obs;
  var isSearchingTrips = false.obs;

  // --- DATA STATE ---
  var terminals = <TerminalModel>[].obs;
  var vehicles = <VehicleModel>[].obs;

  Rx<UserModel?> get currentUser => _authService.currentUser;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
    // Add listeners to check form validity whenever a field changes
    fromCity.listen((_) => _updateFormValidity());
    toCity.listen((_) => _updateFormValidity());
    selectedDate.listen((_) => _updateFormValidity());
    returnDate.listen((_) => _updateFormValidity());
    selectedVehicleType.listen((_) => _updateFormValidity());
    isOneWay.listen((_) => _updateFormValidity());
    _updateFormValidity(); // Initial check
  }

  void _updateFormValidity() {
    bool oneWayValid = isOneWay.value &&
        fromCity.value != 'Select City' &&
        toCity.value != 'Select City' &&
        selectedVehicleType.value != 'Select Vehicle';

    bool roundTripValid = !isOneWay.value &&
        fromCity.value != 'Select City' &&
        toCity.value != 'Select City' &&
        selectedVehicleType.value != 'Select Vehicle' &&
        returnDate.value != 'Select Return Date';
        
    isFormValid.value = oneWayValid || roundTripValid;
  }

  // --- CORE ACTIONS ---
  void logout() { _authService.logout(); }
  void toggleTripType(bool oneWay) { isOneWay.value = oneWay; }
  void incrementSeats() { numberOfSeats.value++; }
  void decrementSeats() { if (numberOfSeats.value > 1) numberOfSeats.value--; }

  // --- DATA FETCHING ---
  Future<void> fetchInitialData() async {
    await Future.wait([ fetchTerminals(), fetchVehicles() ]);
    // Fetch user profile after initial data to populate header
    _authService.getUserProfile();
  }

  Future<void> fetchTerminals({String? search}) async {
    final response = await _bookingService.getTerminals(search: search);
    if (response.status == "success" && response.data != null) {
      terminals.assignAll(response.data!);
    }
  }

  Future<void> fetchVehicles() async {
    final response = await _bookingService.getVehicles();
    if (response.status == "success" && response.data != null) {
      vehicles.assignAll(response.data!);
    }
  }

  // --- NAVIGATION & SUBMISSION ---
  Future<void> searchTripsForBooking() async {
    if (fromCity.value == toCity.value) {
      Get.snackbar("Invalid Selection", "Origin and destination cannot be the same.",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    final originTerminal = terminals.firstWhereOrNull((t) => t.name == fromCity.value);
    final destinationTerminal = terminals.firstWhereOrNull((t) => t.name == toCity.value);
    final parsedDate = DateFormat('dd-MM-yyyy').parse(selectedDate.value);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    isSearchingTrips.value = true;
    final response = await _bookingService.searchTrips(
      date: formattedDate,
      originId: originTerminal!.id,
      destinationId: destinationTerminal!.id,
    );
    isSearchingTrips.value = false;

    if (response.status == "success" && response.data != null) {
      Get.toNamed(
        Routes.TRIP_SELECTION,
        arguments: {
          'trips': response.data!,
          'originName': originTerminal.name,
          'destinationName': destinationTerminal.name,
          'date': formattedDate,
          'selectedVehicleName': selectedVehicleType.value,
          'numberOfSeats': numberOfSeats.value,
        },
      );
    } else {
      Get.snackbar("Trip Search Failed", response.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // --- UI HELPERS ---
  Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
    if (terminals.isEmpty) await fetchTerminals();
    final selectedTerminal = await Get.bottomSheet<TerminalModel>(
      _buildSelectionSheet<TerminalModel>(
        title: 'Select City',
        items: terminals,
        itemBuilder: (terminal) => Text(
          terminal.name,
          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
    if (selectedTerminal != null) {
      if (isFrom) fromCity.value = selectedTerminal.name;
      else toCity.value = selectedTerminal.name;
    }
  }

  Future<void> showVehicleTypeSelectionBottomSheet() async {
    if (vehicles.isEmpty) await fetchVehicles();
    final selectedVehicle = await Get.bottomSheet<VehicleModel>(
      _buildSelectionSheet<VehicleModel>(
        title: 'Select Vehicle',
        items: vehicles,
        itemBuilder: (vehicle) => Text(
          vehicle.name,
          style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
    if (selectedVehicle != null) {
      selectedVehicleType.value = selectedVehicle.name;
    }
  }

  Future<void> openDatePicker({bool isReturnDate = false}) async {
    String initialDateString = isReturnDate ? returnDate.value : selectedDate.value;
    DateTime initialDate;
    try {
      initialDate = DateFormat('dd-MM-yyyy').parse(initialDateString);
    } catch (_) {
      initialDate = DateTime.now();
    }
    
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      if (isReturnDate) {
        returnDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
      } else {
        selectedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
      }
    }
  }

   Widget _buildSelectionSheet<T>({
    required String title,
    required List<T> items,
    required Widget Function(T item) itemBuilder,
  }) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: itemBuilder(item),
                  onTap: () => Get.back(result: item),
                );
              },
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey[200], indent: 20, endIndent: 20),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}