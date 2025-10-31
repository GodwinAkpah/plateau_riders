import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/trip_selection/trip_selection_controller.dart';
import 'package:plateau_riders/services/models/trip_model.dart';


class TripSelectionView extends GetView<TripSelectionController> {
  const TripSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A4F01), Color(0xFF0E2F01)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTripInfo(),
                        const SizedBox(height: 20),
                        Expanded(
                          child: controller.availableTrips.isEmpty
                              ? _buildNoTripsAvailable()
                              : _buildTripsList(),
                        ),
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(height: 10),
          Text(
            'Available Trips',
            style: GoogleFonts.urbanist(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Select a convenient time from available buses',
            style: GoogleFonts.urbanist(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildTripInfo() {
    // --- FIX START ---
    // Safely get the vehicle name from the first trip in the list.
    final vehicleName = controller.availableTrips.isNotEmpty
        ? (controller.availableTrips.first.vehicle?.name ?? 'Trips')
        : 'Trips';
    // --- FIX END ---

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: PlateauColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: PlateauColors.primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  vehicleName, // Use the safe variable
                  style: GoogleFonts.urbanist(
                    color: PlateauColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Obx(() => Text(
                '${controller.originName.value} - ${controller.destinationName.value}',
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
          const SizedBox(height: 5),
          Obx(() => Text(
                '${vehicleName.toUpperCase()} TRIPS  ${controller.tripDate.value}',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildNoTripsAvailable() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/local.png', // Make sure you have a bus image in this path
              height: 100,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 20),
            Text(
              'No Trips Available',
              style: GoogleFonts.urbanist(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'All trips on the selected date are fully booked or unavailable. Please check another date.',
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripsList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: controller.availableTrips.length,
      itemBuilder: (context, index) {
        final trip = controller.availableTrips[index];
        return _buildTripCard(trip);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }

 Widget _buildTripCard(TripModel trip) {
    // --- FIX: Use the new property to check for availability ---
    bool isAvailable = trip.availableSeatsCount > 0;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailColumn('Time', controller.formatTime(trip.time)),
              _buildDetailColumn('Price', controller.formatCurrency(trip.amount),
                  crossAxisAlignment: CrossAxisAlignment.end),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- FIX: Use the new property to display the count ---
              Text(
                '${trip.availableSeatsCount} seat(s) available',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isAvailable ? Colors.green : Colors.red,
                ),
              ),
              Text(
                'Per seat',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isAvailable ? () => controller.selectTrip(trip) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isAvailable ? PlateauColors.primaryColor : Colors.grey[300],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: Text(
                'View',
                style: GoogleFonts.urbanist(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String title, String value,
      {CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}