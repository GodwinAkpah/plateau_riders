import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/auth/authentication_service.dart';
import 'package:plateau_riders/services/booking_service.dart';
import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';
import 'package:plateau_riders/services/models/user_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';



class HomeController extends GetxController {
  // --- SERVICES ---
  // Lazily finds the registered services. Ensure they are registered in your service locator (e.g., in main.dart).
  final AuthenticationService _authService = Get.find<AuthenticationService>();
  final BookingService _bookingService = Get.find<BookingService>();

  // --- UI STATE ---
  // These are observable variables that the UI will listen to for changes.
  var isOneWay = true.obs;
  var fromCity = 'Select City'.obs;
  var toCity = 'Select City'.obs;
  var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  var selectedVehicleType = 'Select Vehicle'.obs;
  var numberOfSeats = 1.obs;

  // --- DATA STATE ---
  // These lists will be populated from the API.
  var terminals = <TerminalModel>[].obs;
  var vehicles = <VehicleModel>[].obs;
  var availableTrips = <TripModel>[].obs;

  // --- CONTROL STATE ---
  // Used to show loading indicators in the UI.
  var isLoading = false.obs; // For initial data loading
  var isSearchingTrips = false.obs; // For the 'Continue' button action

  // --- USER STATE ---
  // A clean getter to access the current user from the AuthenticationService.
  // The UI can observe this directly.
  Rx<UserModel?> get currentUser => _authService.currentUser;

  @override
  void onInit() {
    super.onInit();
    // Fetch all necessary data when the home screen is first loaded.
    fetchInitialData();
  }

  // --- CORE ACTIONS ---

  /// Logs the user out by calling the authentication service.
  void logout() {
    _authService.logout();
  }

  /// Toggles the trip type between 'One Way' and 'Round Trip'.
  void toggleTripType(bool oneWay) {
    isOneWay.value = oneWay;
  }

  /// Increments the number of seats to be booked.
  void incrementSeats() {
    numberOfSeats.value++;
  }

  /// Decrements the number of seats, with a minimum of 1.
  void decrementSeats() {
    if (numberOfSeats.value > 1) {
      numberOfSeats.value--;
    }
  }

  // --- DATA FETCHING METHODS ---

  /// Fetches the user's profile, all terminals, and all vehicles concurrently for a faster UI load.
  Future<void> fetchInitialData() async {
    isLoading.value = true;
    // `Future.wait` runs all async calls at the same time and waits for all to complete.
    await Future.wait([
      _authService.getUserProfile(),
      fetchTerminals(),
      fetchVehicles(),
    ]);
    isLoading.value = false;
  }

  /// Fetches the list of terminals from the API.
  Future<void> fetchTerminals({String? search}) async {
    final response = await _bookingService.getTerminals(search: search);
    if (response.status == "success" && response.data != null) {
      terminals.assignAll(response.data!);
    } else {
      Get.snackbar("Error Loading Terminals", response.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// Fetches the list of vehicles from the API.
  Future<void> fetchVehicles() async {
    final response = await _bookingService.getVehicles();
    if (response.status == "success" && response.data != null) {
      vehicles.assignAll(response.data!);
    } else {
      Get.snackbar("Error Loading Vehicles", response.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  
    Future<void> searchTripsForBooking() async {
    // 1. Validate that origin and destination have been selected.
    if (fromCity.value == 'Select City' || toCity.value == 'Select City') {
      Get.snackbar("Input Required", "Please select both origin and destination cities.",
          backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }

    // --- FIX STARTS HERE ---

    // 2. Find the full Terminal objects based on the selected city names.
    final originTerminal = terminals.firstWhereOrNull((t) => t.name == fromCity.value);
    final destinationTerminal = terminals.firstWhereOrNull((t) => t.name == toCity.value);

    // 3. Perform an explicit null check. This is crucial for null safety.
    if (originTerminal == null || destinationTerminal == null) {
      Get.snackbar("Error", "Selected city is invalid. Please re-select.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    
    // After this check, Dart knows that originTerminal and destinationTerminal are NOT null.

    // 4. Convert the UI date format ('dd-MM-yyyy') to the API format ('yyyy-MM-dd').
    final parsedDate = DateFormat('dd-MM-yyyy').parse(selectedDate.value);
    final formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    // 5. Call the service and handle the response.
    isSearchingTrips.value = true;
    final response = await _bookingService.searchTrips(
      date: formattedDate,
      originId: originTerminal.id, // Now safe to access .id
      destinationId: destinationTerminal.id, // Now safe to access .id
    );
    isSearchingTrips.value = false;

    if (response.status == "success" && response.data != null) {
      // We explicitly cast the response data to the correct type to be safe.
      final List<TripModel> fetchedTrips = response.data!;
      availableTrips.assignAll(fetchedTrips);
      
      // Navigate to the Trip Selection screen with all the necessary data.
      // The red lines will be gone because the compiler is now certain the variables are not null.
      Get.toNamed(
        Routes.TRIP_SELECTION,
        arguments: {
          'trips': fetchedTrips, // Pass the strongly-typed list
          'originName': originTerminal.name, // Now safe to access .name
          'destinationName': destinationTerminal.name, // Now safe to access .name
          'date': formattedDate, // Pass the YYYY-MM-DD date
        },
      );
    } else {
      Get.snackbar("Trip Search Failed", response.message,
          backgroundColor: Colors.red, colorText: Colors.white);
    }
    // --- FIX ENDS HERE ---
  }

  // --- UI HELPER METHODS (BOTTOM SHEETS & PICKERS) ---

    Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
    print('[DEBUG] showCitySelectionBottomSheet called.');
    
    // Ensure terminals are loaded before showing the sheet
    if (terminals.isEmpty) {
      print('[DEBUG] Terminals list is empty. Calling fetchTerminals()...');
      await fetchTerminals();
      print('[DEBUG] fetchTerminals() finished. Current terminals count: ${terminals.length}');
    } else {
      print('[DEBUG] Terminals list already has ${terminals.length} items. Not fetching again.');
    }

    if (terminals.isNotEmpty) {
       print('[DEBUG] Showing bottom sheet with ${terminals.length} items.');
    } else {
       print('[ERROR] Terminals list is still empty. The bottom sheet will be empty.');
    }

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
      print('[DEBUG] User selected terminal: ${selectedTerminal.name}');
      if (isFrom) {
        fromCity.value = selectedTerminal.name;
      } else {
        toCity.value = selectedTerminal.name;
      }
    } else {
      print('[DEBUG] User closed the bottom sheet without selecting.');
    }
  }

  /// Shows a bottom sheet for selecting a 'From' or 'To' city.
  // Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
  //   // Ensure terminals are loaded before showing the sheet
  //   if (terminals.isEmpty) await fetchTerminals();

  //   final selectedTerminal = await Get.bottomSheet<TerminalModel>(
  //     _buildSelectionSheet<TerminalModel>(
  //       title: 'Select City',
  //       items: terminals,
  //       itemBuilder: (terminal) => Text(
  //         terminal.name,
  //         style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
  //       ),
  //     ),
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //   );

  //   if (selectedTerminal != null) {
  //     if (isFrom) {
  //       fromCity.value = selectedTerminal.name;
  //     } else {
  //       toCity.value = selectedTerminal.name;
  //     }
  //   }
  // }

  /// Shows a bottom sheet for selecting a vehicle.
  Future<void> showVehicleTypeSelectionBottomSheet() async {
    // Ensure vehicles are loaded
    if (vehicles.isEmpty) await fetchVehicles();

    final selectedVehicle = await Get.bottomSheet<VehicleModel>(
      _buildSelectionSheet<VehicleModel>(
        title: 'Select Vehicle',
        items: vehicles,
        itemBuilder: (vehicle) => Text(
          vehicle.name, // Displaying the vehicle's name (e.g., "Toyota Hiace")
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

  /// Shows the device's native date picker.
  /// This method is correctly named to avoid conflicts with Flutter's built-in `showDatePicker`.
  Future<void> openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateFormat('dd-MM-yyyy').parse(selectedDate.value),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  /// A generic, reusable widget builder for creating a selection bottom sheet.
  /// This reduces code duplication for city and vehicle selection.
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