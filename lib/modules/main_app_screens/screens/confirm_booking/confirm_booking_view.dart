import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/confirm_booking/confirm_booking_controller.dart';
class ConfirmBookingView extends GetView<ConfirmBookingController> {
  const ConfirmBookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Booking', style: GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please kindly review your information before submitting.',
              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            _buildDetailCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildDetailCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow('Passenger(s)', controller.passengerNames),
          const Divider(height: 24),
          _buildDetailRow('Vehicle Type', controller.trip.vehicle?.name ?? 'N/A'),
          const Divider(height: 24),
          _buildDetailRow('Travelling From', controller.trip.origin.name),
          const Divider(height: 24),
          _buildDetailRow('Destination', controller.trip.destination.name),
          const Divider(height: 24),
          _buildDetailRow(
            'Departure Date',
            DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.trip.date)),
          ),
          const Divider(height: 24),
          _buildDetailRow(
            'Departure Time',
            DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(controller.trip.time)),
          ),
          const Divider(height: 24),
          _buildDetailRow('No. of Seat(s)', '${controller.selectedSeats.length} seats'),
          const Divider(height: 24),
          _buildDetailRow('Seat No.', controller.selectedSeats.join(', ')),
          const Divider(height: 24),
          _buildDetailRow('Amount', controller.totalAmount, isAmount: true),
        ],
      ),
    );
  }

  // --- THIS IS THE IMPLEMENTATION FOR _buildDetailRow ---
  Widget _buildDetailRow(String title, String value, {bool isAmount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 16,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.urbanist(
              fontSize: 16,
              color: isAmount ? PlateauColors.primaryColor : Colors.black,
              fontWeight: isAmount ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // --- THIS IS THE IMPLEMENTATION FOR _buildBottomButtons ---
  Widget _buildBottomButtons() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // Return Button
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(color: PlateauColors.primaryColor),
                ),
                child: Text(
                  'Return',
                  style: GoogleFonts.urbanist(
                    color: PlateauColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Proceed Button
            Expanded(
              child: ElevatedButton(
                onPressed: controller.proceedToPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: PlateauColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Proceed',
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
      ),
    );
  }
}