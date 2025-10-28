
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/modules/main_app_screens/controllers/home_screen_controller.dart';
import 'package:plateau_riders/modules/main_app_screens/widgets/select_city_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.green[800],
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            // You can replace this with a user's profile picture
                            backgroundImage: NetworkImage('https://example.com/user_avatar.png'),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back, ${controller.userName} 👋',
                                style: GoogleFonts.urbanist(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Ready for your next trip?',
                                style: GoogleFonts.urbanist(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.notifications_outlined, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('One Way'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text('Round Trip', style: TextStyle(color: Colors.black54)),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.grey[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildTappableField(
                          context: context,
                          label: 'From',
                          value: controller.fromCity,
                          hint: 'Select City',
                          icon: Icons.directions_bus_filled_outlined,
                          onTap: () async {
                            final result = await _showSelectCityBottomSheet(context);
                            if (result != null) {
                              controller.setFromCity(result);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildTappableField(
                          context: context,
                          label: 'To',
                          value: controller.toCity,
                          hint: 'Select City',
                          icon: Icons.location_on_outlined,
                          onTap: () async {
                            final result = await _showSelectCityBottomSheet(context);
                            if (result != null) {
                              controller.setToCity(result);
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildDateField(context, controller),
                        const SizedBox(height: 16),
                        _buildDropdown(controller, 'Vehicle Type', 'Select Vehicle', Icons.directions_car_filled_outlined),
                        const SizedBox(height: 16),
                        _buildSeatSelector(controller),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Continue'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showSelectCityBottomSheet(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => SelectCityBottomSheet(),
    );
  }

  Widget _buildTappableField({
    required BuildContext context,
    required String label,
    required String? value,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.urbanist(color: Colors.grey[600])),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: InputDecorator(
            decoration: InputDecoration(
              hintText: value ?? hint,
              prefixIcon: Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(value ?? '', style: GoogleFonts.urbanist(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(HomeScreenController controller, String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.urbanist(color: Colors.grey[600])),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          value: controller.vehicleType,
          items: controller.vehicleTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              controller.setVehicleType(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context, HomeScreenController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Departure Date', style: GoogleFonts.urbanist(color: Colors.grey[600])),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: controller.selectedDate == null
                ? 'Select Date'
                : DateFormat('dd-MM-yyyy').format(controller.selectedDate!),
            prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onTap: () => _selectDate(context, controller),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, HomeScreenController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != controller.selectedDate) {
      controller.setSelectedDate(picked);
    }
  }

  Widget _buildSeatSelector(HomeScreenController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Number of Seats', style: GoogleFonts.urbanist(color: Colors.grey[600])),
            Text(controller.seats.toString().padLeft(2, '0'), style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            IconButton(onPressed: controller.decrementSeats, icon: Icon(Icons.remove_circle_outline)),
            Text(controller.seats.toString().padLeft(2, '0'), style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(onPressed: controller.incrementSeats, icon: Icon(Icons.add_circle_outline)),
          ],
        ),
      ],
    );
  }
}
