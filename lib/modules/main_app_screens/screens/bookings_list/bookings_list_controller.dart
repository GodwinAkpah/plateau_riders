import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/services/booking_service.dart';
import 'package:plateau_riders/services/models/booking_model.dart';

class BookingsListController extends GetxController {
  final BookingService _bookingService = Get.find<BookingService>();

  var bookings = <BookingModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    final response = await _bookingService.getBookings();
    if (response.status == 'success' && response.data != null) {
      bookings.assignAll(response.data!);
    } else {
      Get.snackbar('Error', 'Failed to fetch bookings: ${response.message}');
    }
    isLoading.value = false;
  }
  
  String formatDate(String dateString) {
    try {
      // Handles dates like "2025-08-01" or full ISO strings
      return DateFormat('MMM d, yyyy').format(DateTime.parse(dateString));
    } catch (_) {
      return dateString;
    }
  }

  void viewBookingDetails(BookingModel booking) {
    // This is where you would navigate to a full details screen in the future
    // For now, it shows a snackbar with the key information
    Get.snackbar('Booking Tapped', 'Ref: ${booking.refNo} for ${booking.user.fullName}');
  }
}