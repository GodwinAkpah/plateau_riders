// lib/modules/main_app_screens/screens/home_screen/controllers/home_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart'; // For colors in bottom sheets
import 'package:google_fonts/google_fonts.dart'; // For Urbanist font in bottom sheets

class HomeController extends GetxController {
  // --- STATE ---
  var isOneWay = true.obs; // true for One Way, false for Round Trip
  var fromCity = 'Select City'.obs;
  var toCity = 'Select City'.obs;
  var selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs; // Initial date
  var selectedVehicleType = 'Select Vehicle'.obs;
  var numberOfSeats = 1.obs;

  // --- ACTIONS ---

  void toggleTripType(bool oneWay) {
    isOneWay.value = oneWay;
  }

  void incrementSeats() {
    numberOfSeats.value++;
  }

  void decrementSeats() {
    if (numberOfSeats.value > 1) { // Minimum 1 seat
      numberOfSeats.value--;
    }
  }

  // --- Bottom Sheet Logic ---

  Future<void> showCitySelectionBottomSheet({required bool isFrom}) async {
    final List<String> availableCities = ['F.C.T, Abuja', 'Plateau, Jos']; // Example cities
    final selected = await Get.bottomSheet<String>(
      _buildCitySelectionSheet(availableCities),
      backgroundColor: Colors.transparent, // Make transparent to show custom shape
      isScrollControlled: true, // Allows content to take more space
    );

    if (selected != null) {
      if (isFrom) {
        fromCity.value = selected;
      } else {
        toCity.value = selected;
      }
    }
  }

  Widget _buildCitySelectionSheet(List<String> cities) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0), // Adjust padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
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
              'Select City',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Flexible( // Use Flexible to constrain height if many cities
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cities.length,
              itemBuilder: (context, index) {
                final city = cities[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        city,
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => Get.back(result: city),
                    ),
                    if (index < cities.length - 1)
                      Divider(height: 1, color: Colors.grey[200], indent: 20, endIndent: 20),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> showDatePickerBottomSheet() async {
    // For now, we use Flutter's default date picker, which doesn't match the design.
    // The custom widget `_buildCustomDatePickerSheet` will be integrated once built.
    // For a quick implementation that looks okay, we can use Get.bottomSheet with a custom builder.

    final DateTime? pickedDate = await Get.bottomSheet<DateTime>(
      _buildCustomDatePickerSheet(selectedDate.value),
      backgroundColor: Colors.transparent, // Make transparent to show custom shape
      isScrollControlled: true,
    );

    if (pickedDate != null) {
      selectedDate.value = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }

  Widget _buildCustomDatePickerSheet(String currentSelectedDateString) {
    // This is a placeholder for your actual custom date picker UI
    // It replicates the general structure and interactive elements from your screenshot.
    // The actual calendar logic (day grid, month/year navigation) needs to be implemented.

    DateTime initialDate = DateTime.tryParse(DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(currentSelectedDateString))) ?? DateTime.now();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '2025', // Year as per design
              style: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: PlateauColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat('EEE. MMM d').format(initialDate), // E.g., Thu. Feb 5
              style: GoogleFonts.urbanist(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'March', // Current month
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              DropdownButton<int>( // Year dropdown
                value: 2025, // Placeholder
                items: <int>[2023, 2024, 2025, 2026, 2027].map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text('$year', style: GoogleFonts.urbanist(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  // TODO: Implement year change logic
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Months Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.5, // Adjust for button size
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = DateFormat('MMM').format(DateTime(2025, index + 1));
              bool isCurrentMonth = index + 1 == initialDate.month; // Placeholder logic
              return GestureDetector(
                onTap: () {
                  // TODO: Implement month selection
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isCurrentMonth ? PlateauColors.primaryColor : Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    month,
                    style: GoogleFonts.urbanist(
                      color: isCurrentMonth ? Colors.white : Colors.black,
                      fontWeight: isCurrentMonth ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Days Grid (Placeholder - you'll need to generate this dynamically)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Days of the month (e.g., 1, 2, 3...)',
              style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [PlateauColors.primaryColor, PlateauColors.darkGreen],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              onPressed: () {
                // Return the currently selected date (placeholder for now)
                Get.back(result: initialDate); // Example: returning the initial date
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadowColor: Colors.transparent,
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> showVehicleTypeSelectionBottomSheet() async {
    final List<String> vehicleTypes = ['Sienna', '16-Seater', 'Coaster', 'Hummer Bus', 'Hilux']; // Example vehicle types
    final selected = await Get.bottomSheet<String>(
      _buildVehicleTypeSelectionSheet(vehicleTypes),
      backgroundColor: Colors.transparent, // Make transparent
      isScrollControlled: true,
    );

    if (selected != null) {
      selectedVehicleType.value = selected;
    }
  }

  Widget _buildVehicleTypeSelectionSheet(List<String> types) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
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
              'Select Vehicle',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: types.length,
              itemBuilder: (context, index) {
                final type = types[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        type,
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => Get.back(result: type),
                    ),
                    if (index < types.length - 1)
                      Divider(height: 1, color: Colors.grey[200], indent: 20, endIndent: 20),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}