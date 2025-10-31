// // lib/services/models/trip_model.dart
// import 'package:plateau_riders/services/models/terminal_model.dart';
// import 'package:plateau_riders/services/models/vehicle_model.dart';

// class TripModel {
//   final int id;
//   final int remainingSeats;
//   final String time; // Departure time
//   final String amount;
//   final int capacity;
//   final String date;
//   final TerminalModel origin;
//   final TerminalModel destination;
//   final VehicleModel vehicle;

//   TripModel({
//     required this.id,
//     required this.remainingSeats,
//     required this.time,
//     required this.amount,
//     required this.capacity,
//     required this.date,
//     required this.origin,
//     required this.destination,
//     required this.vehicle,
//   });

//   factory TripModel.fromMap(Map<String, dynamic> map) {
//     return TripModel(
//       id: map['id']?.toInt() ?? 0,
//       remainingSeats: map['remaining_seats']?.toInt() ?? 0,
//       time: map['time'] ?? '',
//       amount: map['amount'] ?? '0',
//       capacity: map['capacity']?.toInt() ?? 0,
//       date: map['date'] ?? '',
//       origin: TerminalModel.fromMap(map['origin'] ?? {}),
//       destination: TerminalModel.fromMap(map['destination'] ?? {}),
//       vehicle: VehicleModel.fromMap(map['vehicle'] ?? {}),
//     );
//   }
// }
import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';

class TripModel {
  final int id;
  // --- FIX: Changed from remainingSeats to availableSeatsCount ---
  final int availableSeatsCount; 
  final String time; // Departure time
  final String amount;
  final int capacity;
  final String date;
  final TerminalModel origin;
  final TerminalModel destination;
  // Vehicle can be null, so we make it nullable
  final VehicleModel? vehicle; 

  TripModel({
    required this.id,
    required this.availableSeatsCount, // Updated property
    required this.time,
    required this.amount,
    required this.capacity,
    required this.date,
    required this.origin,
    required this.destination,
    this.vehicle, // Updated property
  });

  factory TripModel.fromMap(Map<String, dynamic> map) {
    // --- FIX: Logic to calculate seat count from the array ---
    int seatCount = 0;
    if (map['available_seats'] != null && map['available_seats'] is List) {
      // The number of available seats is the length of the array
      seatCount = (map['available_seats'] as List).length;
    } else if (map['remaining_seats'] != null) {
      // Fallback for the old API response structure, just in case
      seatCount = map['remaining_seats']?.toInt() ?? 0;
    }
    // --- End of Fix ---

    return TripModel(
      id: map['id']?.toInt() ?? 0,
      availableSeatsCount: seatCount, // Use the calculated count
      time: map['time'] ?? '',
      amount: map['amount']?.toString() ?? '0', // Ensure amount is a string
      capacity: map['capacity']?.toInt() ?? 0,
      date: map['date'] ?? '',
      origin: TerminalModel.fromMap(map['origin'] ?? {}),
      destination: TerminalModel.fromMap(map['destination'] ?? {}),
      // Handle the case where vehicle might be null
      vehicle: map['vehicle'] != null ? VehicleModel.fromMap(map['vehicle']) : null,
    );
  }
}