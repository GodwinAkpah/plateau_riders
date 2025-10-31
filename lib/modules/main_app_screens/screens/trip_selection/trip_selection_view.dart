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
                    // Use Obx to rebuild the body when the filter or trips list changes
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTripInfo(), // Displays Origin - Destination
                        _buildVehicleFilterChips(), // The new filter chips
                        const SizedBox(height: 10),
                        Expanded(
                          child: controller.allAvailableTrips.isEmpty
                              ? _buildNoTripsAvailable()
                              // Pass the computed 'filteredTrips' list to the builder
                              : _buildTripsList(controller.filteredTrips),
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
          // A cleaner back button
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                'TRIPS FOR ${controller.tripDate.value}',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              )),
          // The SizedBox is moved to the parent Column for better spacing
        ],
      ),
    );
  }

  Widget _buildVehicleFilterChips() {
    // Add a little vertical spacing
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: controller.uniqueVehicles.length,
          itemBuilder: (context, index) {
            final vehicle = controller.uniqueVehicles[index];
            // The chip is wrapped in Obx to react to selection changes
            return Obx(() {
              final isSelected = controller.selectedVehicleId.value == vehicle.id;
              return ChoiceChip(
                label: Text(vehicle.name),
                selected: isSelected,
                onSelected: (_) => controller.setVehicleFilter(vehicle.id),
                backgroundColor: Colors.grey[200],
                selectedColor: PlateauColors.primaryColor.withOpacity(0.9),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.transparent),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              );
            });
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        ),
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
            // Ensure you have a bus image asset at this path
            Image.asset(
              'assets/imgs/bus.png', 
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

  Widget _buildTripsList(List<TripModel> trips) {
    if (trips.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No trips available for this vehicle type.',
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey[700]),
          ),
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: trips.length,
      itemBuilder: (context, index) {
        final trip = trips[index];
        return _buildTripCard(trip);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
    );
  }

 Widget _buildTripCard(TripModel trip) {
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
        children: [
          // --- FIX: ADDED THIS WIDGET TO SHOW THE VEHICLE NAME ---
          Row(
            children: [
              Icon(Icons.directions_bus, color: Colors.grey[600], size: 18),
              const SizedBox(width: 8),
              Text(
                // Safely access the vehicle name, providing a fallback
                trip.vehicle?.name ?? 'Unassigned Vehicle',
                style: GoogleFonts.urbanist(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const Divider(height: 24), // Adds a nice visual separation
          // ----------------------- END OF FIX -----------------------

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