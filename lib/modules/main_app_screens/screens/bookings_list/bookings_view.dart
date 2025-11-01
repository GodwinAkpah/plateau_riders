import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/bookings_list/bookings_list_controller.dart';

class BookingsListView extends GetView<BookingsListController> {
  const BookingsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Bookings', style: GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.bookings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.list_alt, size: 80, color: Colors.grey[300]),
                const SizedBox(height: 16),
                const Text(
                  'No bookings have been made yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        // RefreshIndicator allows the admin to pull down to refresh the list
        return RefreshIndicator(
          onRefresh: () => controller.fetchBookings(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.bookings.length,
            itemBuilder: (context, index) {
              final booking = controller.bookings[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(
                    '${booking.trip.origin.name} to ${booking.trip.destination.name}',
                    style: GoogleFonts.urbanist(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Passenger: ${booking.user.fullName}', style: const TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text('Date: ${controller.formatDate(booking.trip.date)}'),
                        const SizedBox(height: 4),
                        Text('Ref: ${booking.refNo}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Seat',
                        style: GoogleFonts.urbanist(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '${booking.seatNo}',
                        style: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.bold, color: PlateauColors.primaryColor),
                      ),
                    ],
                  ),
                  onTap: () => controller.viewBookingDetails(booking),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}