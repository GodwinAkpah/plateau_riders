


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
// import 'package:plateau_riders/modules/main_app_screens/screens/select_seat/select_seat_controller.dart';

// class SelectSeatView extends GetView<SelectSeatController> {
//   const SelectSeatView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Seat(s)', style: GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           _buildTripHeader(),
//           Expanded(child: _buildSeatMap()),
//           _buildBottomSummary(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTripHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Row(
//         children: [
//           // You can add a vehicle image here if you have one
//           // Image.asset(controller.trip.vehicle?.name ...),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '${controller.trip.origin.name} to ${controller.trip.destination.name}',
//                   style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   DateFormat('EEEE, MMMM d, yyyy').format(DateTime.parse(controller.trip.date)),
//                   style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(controller.trip.time)),
//                 style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 controller.trip.vehicle?.name ?? 'N/A',
//                 style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey[600]),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildSeatMap() {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         children: [
//           // You will need to create an asset for this image
//           Image.asset('assets/imgs/bus.png', height: 150),
//           const SizedBox(height: 20),
//           _buildLegend(),
//           const SizedBox(height: 20),
//           Expanded(
//             child: Obx(() => GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4, // Adjust this number for your bus layout
//                 crossAxisSpacing: 12,
//                 mainAxisSpacing: 12,
//               ),
//               itemCount: controller.allSeatNumbers.length,
//               itemBuilder: (context, index) {
//                 final seatNumber = controller.allSeatNumbers[index];
//                 return Obx(() => _buildSeatWidget(seatNumber));
//               },
//             )),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- THIS IS THE CORE LOGIC FOR DISPLAYING SEAT STATUS ---
//   Widget _buildSeatWidget(int seatNumber) {
//     // Determine the state of the seat
//     final bool isBooked = controller.bookedSeats.contains(seatNumber);
//     final bool isSelected = controller.selectedSeats.contains(seatNumber);

//     // Default styles for an "Available" seat
//     Color backgroundColor = Colors.white;
//     Color borderColor = Colors.grey[400]!;
//     Color textColor = Colors.black;
//     VoidCallback? onTapAction = () => controller.toggleSeatSelection(seatNumber);

//     // Apply styles for a "Booked" seat
//     if (isBooked) {
//       backgroundColor = Colors.red.withOpacity(0.3);
//       borderColor = Colors.red.withOpacity(0.5);
//       textColor = Colors.white;
//       onTapAction = null; // Make it untappable
//     }

//     // Apply styles for a "Selected" seat (this overrides other styles)
//     if (isSelected) {
//       backgroundColor = PlateauColors.primaryColor;
//       borderColor = PlateauColors.primaryColor;
//       textColor = Colors.white;
//     }

//     return GestureDetector(
//       onTap: onTapAction,
//       child: Container(
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: borderColor),
//         ),
//         child: Center(
//           child: Text(
//             '$seatNumber',
//             style: GoogleFonts.urbanist(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLegend() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _legendItem(Colors.red.withOpacity(0.5), 'Booked'),
//         _legendItem(Colors.grey[200]!, 'Available'),
//         _legendItem(PlateauColors.primaryColor, 'Selected'),
//       ],
//     );
//   }

//   Widget _legendItem(Color color, String text) {
//     return Row(
//       children: [
//         Container(
//           width: 16,
//           height: 16,
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(color: Colors.grey[400]!, width: 0.5),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(text, style: GoogleFonts.urbanist()),
//       ],
//     );
//   }

//   Widget _buildBottomSummary() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           )
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Seats', style: GoogleFonts.urbanist(color: Colors.grey[600])),
//           const SizedBox(height: 4),
//           Obx(() => Text(
//                 controller.selectedSeats.isEmpty
//                     ? 'No seats selected'
//                     : controller.selectedSeats.join(', '),
//                 style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold),
//               )),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('Total Price', style: GoogleFonts.urbanist(color: Colors.grey[600])),
//               Obx(() {
//                 final amount = double.tryParse(controller.trip.amount) ?? 0.0;
//                 final total = amount * controller.selectedSeats.length;
//                 final formattedTotal = NumberFormat.currency(
//                   locale: 'en_NG', symbol: '₦', decimalDigits: 2
//                 ).format(total);
//                 return Text(
//                   formattedTotal,
//                   style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.bold, color: PlateauColors.primaryColor),
//                 );
//               }),
//             ],
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             width: double.infinity,
//             child: Obx(() => ElevatedButton(
//               onPressed: controller.selectedSeats.length == controller.seatsToSelectCount
//                   ? controller.proceedToPassengerDetails
//                   : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: PlateauColors.primaryColor,
//                 disabledBackgroundColor: Colors.grey.withOpacity(0.5),
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//               ),
//               child: Text(
//                 'Continue',
//                 style: GoogleFonts.urbanist(
//                     color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/select_seat/select_seat_controller.dart';

class SelectSeatView extends GetView<SelectSeatController> {
  const SelectSeatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seat(s)', style: GoogleFonts.urbanist(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildTripHeader(),
          Expanded(child: _buildSeatMap()),
          _buildBottomSummary(),
        ],
      ),
    );
  }

   Widget _buildTripHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // You can add a vehicle image here if you have one
          // Image.asset(controller.trip.vehicle?.name ...),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${controller.trip.origin.name} to ${controller.trip.destination.name}',
                  style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('EEEE, MMMM d, yyyy').format(DateTime.parse(controller.trip.date)),
                  style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('hh:mm a').format(DateFormat('HH:mm:ss').parse(controller.trip.time)),
                style: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                controller.trip.vehicle?.name ?? 'N/A',
                style: GoogleFonts.urbanist(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSeatMap() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Ensure you have an asset at this path
          Image.asset('assets/imgs/bus.png', height: 150),
          const SizedBox(height: 20),
          _buildLegend(),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: controller.allSeatNumbers.length,
              itemBuilder: (context, index) {
                final seatNumber = controller.allSeatNumbers[index];
                // Wrap each seat in an Obx so only it rebuilds on selection change
                return Obx(() => _buildSeatWidget(seatNumber));
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatWidget(int seatNumber) {
    // Determine the state of the seat
    final bool isBooked = controller.bookedSeats.contains(seatNumber);
    final bool isSelected = controller.selectedSeats.contains(seatNumber);

    // Default styles for an "Available" seat
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey[400]!;
    Color textColor = Colors.black;
    VoidCallback? onTapAction = () => controller.toggleSeatSelection(seatNumber);

    // Apply styles for a "Booked" seat
    if (isBooked) {
      backgroundColor = Colors.red.withOpacity(0.3);
      borderColor = Colors.red.withOpacity(0.5);
      textColor = Colors.white;
      onTapAction = null; // Make it untappable
    }

    // Apply styles for a "Selected" seat (this overrides other styles)
    if (isSelected) {
      backgroundColor = PlateauColors.primaryColor;
      borderColor = PlateauColors.primaryColor;
      textColor = Colors.white;
    }

    return GestureDetector(
      onTap: onTapAction,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            '$seatNumber',
            style: GoogleFonts.urbanist(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _legendItem(Colors.red.withOpacity(0.5), 'Booked'),
        _legendItem(Colors.grey[200]!, 'Available'),
        _legendItem(PlateauColors.primaryColor, 'Selected'),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey[400]!, width: 0.5),
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: GoogleFonts.urbanist()),
      ],
    );
  }

  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Seats', style: GoogleFonts.urbanist(color: Colors.grey[600])),
          const SizedBox(height: 4),
          Obx(() => Text(
                controller.selectedSeats.isEmpty
                    ? 'No seats selected'
                    : controller.selectedSeats.join(', '),
                style: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Price', style: GoogleFonts.urbanist(color: Colors.grey[600])),
              Obx(() {
                final amount = double.tryParse(controller.trip.amount) ?? 0.0;
                final total = amount * controller.selectedSeats.length;
                final formattedTotal = NumberFormat.currency(
                  locale: 'en_NG', symbol: '₦', decimalDigits: 2
                ).format(total);
                return Text(
                  formattedTotal,
                  style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.bold, color: PlateauColors.primaryColor),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Obx(() => ElevatedButton(
              onPressed: controller.selectedSeats.length == controller.seatsToSelectCount
                  ? controller.proceedToPassengerDetails
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: PlateauColors.primaryColor,
                disabledBackgroundColor: Colors.grey.withOpacity(0.5),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.urbanist(
                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )),
          ),
        ],
      ),
    );
  }
}