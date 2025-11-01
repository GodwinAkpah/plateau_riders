// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/home_screen.dart';
// import 'package:plateau_riders/services/booking_service.dart';
// import 'package:plateau_riders/services/models/passenger_info_model.dart';
// import 'package:plateau_riders/services/models/trip_model.dart';

// import 'package:plateau_riders/routing/app_pages.dart';


// class PassengerDetailsController extends GetxController {
//   final BookingService _bookingService = Get.find<BookingService>();

//   // --- STATE ---
//   late TripModel trip;
//   late int numberOfSeats;
  
//   var passengerForms = <PassengerInfo>[].obs;
//   late PageController pageController;
//   var currentPage = 0.obs;
//   var isBooking = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     final Map<String, dynamic> args = Get.arguments;
//     trip = args['trip'] as TripModel;
//     numberOfSeats = args['numberOfSeats'] as int;

//     // Create one form data holder for each seat
//     for (int i = 0; i < numberOfSeats; i++) {
//       passengerForms.add(PassengerInfo());
//     }

//     pageController = PageController();
//   }

//   void onPageChanged(int index) {
//     currentPage.value = index;
//   }

//   // Go to the next form page
//   void nextPage() {
//     // Validate the current form before proceeding
//     if (passengerForms[currentPage.value].formKey.currentState!.validate() && 
//         passengerForms[currentPage.value].selectedGender != null) {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     } else {
//       Get.snackbar('Incomplete Form', 'Please fill all fields for this passenger.',
//         backgroundColor: Colors.orange, colorText: Colors.white);
//     }
//   }

//   // The main booking logic
//   Future<void> submitAllBookings() async {
//     // First, validate the final form
//      if (!passengerForms[currentPage.value].formKey.currentState!.validate() ||
//         passengerForms[currentPage.value].selectedGender == null) {
//       Get.snackbar('Incomplete Form', 'Please fill all fields for this passenger.',
//           backgroundColor: Colors.orange, colorText: Colors.white);
//       return;
//     }
    
//     isBooking.value = true;
//     final seatsToBook = trip.availableSeats.take(numberOfSeats).toList();
//     final successfulBookings = [];
//     String? firstErrorMessage;

//     // Loop through each form and make an API call
//     for (int i = 0; i < passengerForms.length; i++) {
//       final passenger = passengerForms[i];
//       final seatNo = seatsToBook[i];

//       final response = await _bookingService.bookSingleSeat(
//         customerName: passenger.nameController.text,
//         customerEmail: passenger.emailController.text,
//         customerPhone: passenger.phoneController.text,
//         customerGender: passenger.selectedGender!,
//         customerNextOfKin: passenger.nokNameController.text,
//         customerNextOfKinPhone: passenger.nokPhoneController.text,
//         seatNo: seatNo,
//         tripId: trip.id,
//       );

//       if (response.status == 'success') {
//         successfulBookings.add(response.data);
//       } else {
//         // If one fails, store the error and stop
//         firstErrorMessage = response.message;
//         break;
//       }
//     }
    
//     isBooking.value = false;

//     if (firstErrorMessage != null) {
//       Get.snackbar('Booking Failed', firstErrorMessage,
//           backgroundColor: Colors.red, colorText: Colors.white);
//     } else {
//       Get.defaultDialog(
//         title: 'Booking Successful!',
//         middleText: 'Successfully booked ${successfulBookings.length} seat(s).',
//         textConfirm: 'OK',
//         onConfirm: () => Get.offAllNamed(Routes.MAINBOTTOMNAV),
//       );
//     }
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     for (var form in passengerForms) {
//       form.dispose();
//     }
//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/models/passenger_info_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';

class PassengerDetailsController extends GetxController {
  // --- STATE ---
  late TripModel trip;
  late List<int> selectedSeats;
  late int numberOfSeats; // <-- ADDED THIS PROPERTY

  var passengerForms = <PassengerInfo>[].obs;
  late PageController pageController;
  var currentPage = 0.obs;

  var isBooking = false.obs; // <-- ADDED THIS FOR THE LOADING INDICATOR

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    trip = args['trip'];
    selectedSeats = args['selectedSeats'];
    numberOfSeats = selectedSeats.length; // <-- INITIALIZE IT HERE

    // Create one form data holder for each seat
    for (int i = 0; i < numberOfSeats; i++) {
      passengerForms.add(PassengerInfo());
    }

    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  bool _validateCurrentForm() {
    final currentPassenger = passengerForms[currentPage.value];
    bool isFormValid = currentPassenger.formKey.currentState?.validate() ?? false;
    bool isGenderSelected = currentPassenger.selectedGender != null;
    if (!isGenderSelected && isFormValid) { // Only show if other fields are valid
      Get.snackbar('Incomplete Form', 'Please select a gender for this passenger.',
          backgroundColor: Colors.orange, colorText: Colors.white);
    }
    return isFormValid && isGenderSelected;
  }

  void nextPage() {
    if (_validateCurrentForm()) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  // --- RENAMED METHOD ---
  // This method proceeds to the summary/confirmation screen.
  void proceedToConfirmation() {
    if (!_validateCurrentForm()) return; // Validate the last page

    Get.toNamed(Routes.CONFIRM_BOOKING, arguments: {
      'trip': trip,
      'passengers': passengerForms,
      'selectedSeats': selectedSeats,
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    for (var form in passengerForms) {
      form.dispose();
    }
    super.onClose();
  }
}