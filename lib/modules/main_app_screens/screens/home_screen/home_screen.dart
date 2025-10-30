// // lib/modules/main_app_screens/screens/home_screen/home_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/controllers/home_controller.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: PlateauColors.backgroundColor,
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Column(
//                   children: [
//                     _buildTripTypeToggle(),
//                     const SizedBox(height: 20),
//                     _buildInputFieldsContainer(),
//                     const SizedBox(height: 30),
//                     _buildContinueButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           // User Avatar
//           CircleAvatar(
//             radius: 24,
//             // Corrected asset path to match error and common usage
//             backgroundImage: AssetImage('assets/imgs/avatar.png'),
//             backgroundColor: PlateauColors.primaryColor,
//           ),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome back, Sarah 👋',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   'Ready for your next trip?',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Notification Bell
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.notifications_none, color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTripTypeToggle() {
//     return Obx(
//       () => Container(
//         padding: const EdgeInsets.all(5),
//         decoration: BoxDecoration(
//           color: PlateauColors.toggleBackground,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildToggleOption(
//               label: 'One Way',
//               isSelected: controller.isOneWay.value,
//               onTap: () => controller.toggleTripType(true),
//             ),
//             _buildToggleOption(
//               label: 'Round Trip',
//               isSelected: !controller.isOneWay.value,
//               onTap: () => controller.toggleTripType(false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildToggleOption({required String label, required bool isSelected, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? PlateauColors.primaryColor : Colors.transparent,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Text(
//           label,
//           style: GoogleFonts.urbanist(
//             color: isSelected ? Colors.white : Colors.grey[700],
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputFieldsContainer() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // Wrapped in Obx
//           Obx(() => _buildLocationInputField(
//             icon: Icons.directions_bus,
//             label: 'From',
//             value: controller.fromCity.value,
//             onTap: () => controller.showCitySelectionBottomSheet(isFrom: true),
//           )),
//           Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
//           // Wrapped in Obx
//           Obx(() => _buildLocationInputField(
//             icon: Icons.directions_bus,
//             label: 'To',
//             value: controller.toCity.value,
//             onTap: () => controller.showCitySelectionBottomSheet(isFrom: false),
//           )),
//           Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
//           // Wrapped in Obx
//           Obx(() => _buildDateField(
//             value: controller.selectedDate.value,
//             onTap: () => controller.showDatePickerBottomSheet(),
//           )),
//           Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
//           // Wrapped in Obx
//           Obx(() => _buildVehicleTypeField(
//             value: controller.selectedVehicleType.value,
//             onTap: () => controller.showVehicleTypeSelectionBottomSheet(),
//           )),
//           Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
//           // The increment/decrement logic will trigger the Obx for numberOfSeats value.
//           _buildNumberOfSeatsField(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocationInputField({
//     required IconData icon,
//     required String label,
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.grey[600]),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: GoogleFonts.urbanist(
//                     fontSize: 12,
//                     color: Colors.grey[500],
//                   ),
//                 ),
//                 Text( // This Text widget is now inside an Obx from its parent.
//                   value,
//                   style: GoogleFonts.urbanist(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateField({
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(Icons.calendar_today_outlined, color: Colors.grey[600]),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Departure Date',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 12,
//                     color: Colors.grey[500],
//                   ),
//                 ),
//                 Text( // This Text widget is now inside an Obx from its parent.
//                   value,
//                   style: GoogleFonts.urbanist(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildVehicleTypeField({
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(Icons.directions_car_outlined, color: Colors.grey[600]),
//           const SizedBox(width: 15),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Vehicle Type',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 12,
//                     color: Colors.grey[500],
//                   ),
//                 ),
//                 Text( // This Text widget is now inside an Obx from its parent.
//                   value,
//                   style: GoogleFonts.urbanist(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//         ],
//       ),
//     );
//   }

//   Widget _buildNumberOfSeatsField() {
//     return Row(
//       children: [
//         Icon(Icons.event_seat_outlined, color: Colors.grey[600]),
//         const SizedBox(width: 15),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Number of Seats',
//                 style: GoogleFonts.urbanist(
//                   fontSize: 12,
//                   color: Colors.grey[500],
//                 ),
//               ),
//               Obx(() => Text( // This Obx specifically listens to numberOfSeats.value
//                 '${controller.numberOfSeats.value}',
//                 style: GoogleFonts.urbanist(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               )),
//             ],
//           ),
//         ),
//         // Plus/Minus Buttons
//         Container(
//           decoration: BoxDecoration(
//             color: PlateauColors.toggleBackground,
//             borderRadius: BorderRadius.circular(30),
//           ),
//           child: Row(
//             children: [
//               IconButton(
//                 iconSize: 20,
//                 constraints: BoxConstraints(),
//                 padding: EdgeInsets.zero,
//                 icon: Icon(Icons.remove, color: PlateauColors.primaryColor),
//                 onPressed: controller.decrementSeats,
//               ),
//               Obx(() => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Text(
//                   '${controller.numberOfSeats.value}',
//                   style: GoogleFonts.urbanist(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//               )),
//               IconButton(
//                 iconSize: 20,
//                 constraints: BoxConstraints(),
//                 padding: EdgeInsets.zero,
//                 icon: Icon(Icons.add, color: PlateauColors.primaryColor),
//                 onPressed: controller.incrementSeats,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildContinueButton() {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [PlateauColors.primaryColor, PlateauColors.darkGreen],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: ElevatedButton(
//         onPressed: () {
//           Get.snackbar("Booking", "Continue button pressed!");
//           print("From: ${controller.fromCity.value}, To: ${controller.toCity.value}, Date: ${controller.selectedDate.value}, Vehicle: ${controller.selectedVehicleType.value}, Seats: ${controller.numberOfSeats.value}");
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           shadowColor: Colors.transparent,
//         ),
//         child: Text(
//           'Continue',
//           style: GoogleFonts.urbanist(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/controllers/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PlateauColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    _buildTripTypeToggle(),
                    const SizedBox(height: 20),
                    _buildInputFieldsContainer(),
                    const SizedBox(height: 30),
                    _buildContinueButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          // User Avatar
          Obx(() => CircleAvatar(
                radius: 24,
                backgroundImage: controller.currentUser.value?.avatar != null &&
                        controller.currentUser.value!.avatar!.isNotEmpty
                    ? NetworkImage(controller.currentUser.value!.avatar!)
                        as ImageProvider
                    : const AssetImage('assets/imgs/avatar.png'),
                backgroundColor: PlateauColors.primaryColor,
              )),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      'Welcome back, ${controller.currentUser.value?.firstname ?? 'User'} 👋',
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
                Text(
                  'Ready for your next trip?',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Notification & Logout Icons
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notifications_none, color: Colors.black),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: controller.logout,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.logout, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripTypeToggle() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: PlateauColors.toggleBackground,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleOption(
              label: 'One Way',
              isSelected: controller.isOneWay.value,
              onTap: () => controller.toggleTripType(true),
            ),
            _buildToggleOption(
              label: 'Round Trip',
              isSelected: !controller.isOneWay.value,
              onTap: () => controller.toggleTripType(false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(
      {required String label,
      required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? PlateauColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: GoogleFonts.urbanist(
            color: isSelected ? Colors.white : Colors.grey[700],
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildInputFieldsContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Obx(() => _buildLocationInputField(
                icon: Icons.directions_bus,
                label: 'From',
                value: controller.fromCity.value,
                onTap: () =>
                    controller.showCitySelectionBottomSheet(isFrom: true),
              )),
          Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
          Obx(() => _buildLocationInputField(
                icon: Icons.directions_bus,
                label: 'To',
                value: controller.toCity.value,
                onTap: () =>
                    controller.showCitySelectionBottomSheet(isFrom: false),
              )),
          Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
          Obx(() => _buildDateField(
                value: controller.selectedDate.value,
                onTap: () => controller.openDatePicker(), // <-- CORRECTED METHOD NAME
              )),
          Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
          Obx(() => _buildVehicleTypeField(
                value: controller.selectedVehicleType.value,
                onTap: () => controller.showVehicleTypeSelectionBottomSheet(),
              )),
          Divider(height: 25, thickness: 0.8, color: Colors.grey[200]),
          _buildNumberOfSeatsField(),
        ],
      ),
    );
  }

  Widget _buildLocationInputField({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, color: Colors.grey[600]),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Departure Date',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildVehicleTypeField({
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(Icons.directions_car_outlined, color: Colors.grey[600]),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vehicle Type',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildNumberOfSeatsField() {
    return Row(
      children: [
        Icon(Icons.event_seat_outlined, color: Colors.grey[600]),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            'Number of Seats',
            style: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: PlateauColors.toggleBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.remove, color: PlateauColors.primaryColor),
                onPressed: controller.decrementSeats,
              ),
              Obx(() => Text(
                    '${controller.numberOfSeats.value}',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )),
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.add, color: PlateauColors.primaryColor),
                onPressed: controller.incrementSeats,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => ElevatedButton(
            onPressed: controller.isSearchingTrips.value
                ? null // Disable button while searching
                : controller.searchTripsForBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: PlateauColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              shadowColor: Colors.transparent,
            ),
            child: controller.isSearchingTrips.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Text(
                    'Continue',
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          )),
    );
  }
}