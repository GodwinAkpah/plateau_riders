import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/booking_service.dart';
import 'package:plateau_riders/services/models/passenger_info_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';
class MakePaymentController extends GetxController {
  final BookingService _bookingService = Get.find<BookingService>();
  
  late TripModel trip;
  late List<PassengerInfo> passengers;
  late List<int> selectedSeats;

  var isBooking = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    trip = args['trip'];
    passengers = args['passengers'];
    selectedSeats = args['selectedSeats'];
  }

  Future<void> processPaymentAndBook() async {
    isBooking.value = true;
    
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    String? firstErrorMessage;
    
    for (int i = 0; i < passengers.length; i++) {
      final passenger = passengers[i];
      final seatNo = selectedSeats[i];
      final response = await _bookingService.bookSingleSeat(
        customerName: passenger.nameController.text,
        customerEmail: passenger.emailController.text,
        customerPhone: passenger.phoneController.text,
        customerGender: passenger.selectedGender!,
        customerNextOfKin: passenger.nokNameController.text,
        customerNextOfKinPhone: passenger.nokPhoneController.text,
        seatNo: seatNo,
        tripId: trip.id,
      );
      if (response.status != 'success') {
        firstErrorMessage = response.message;
        break;
      }
    }
    
    isBooking.value = false;

    if (firstErrorMessage != null) {
      Get.snackbar('Booking Failed', firstErrorMessage, backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      Get.defaultDialog(
        title: 'Booking Successful!',
        middleText: 'Successfully booked ${passengers.length} seat(s).',
        textConfirm: 'Done',
        onConfirm: () => Get.offAllNamed(Routes.MAINBOTTOMNAV),
      );
    }
  }
}

