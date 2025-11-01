// // import 'package:plateau_riders/services/models/terminal_model.dart';
// // import 'package:plateau_riders/services/models/vehicle_model.dart';

// // class TripModel {
// //   final int id;
// //   final int availableSeatsCount;
// //   // --- FIX: Add a property to store the actual list of seat numbers ---
// //   final List<int> availableSeats;
// //   // -----------------------------------------------------------------
// //   final String time;
// //   final String amount;
// //   final int capacity;
// //   final String date;
// //   final TerminalModel origin;
// //   final TerminalModel destination;
// //   final VehicleModel? vehicle;

// //   TripModel({
// //     required this.id,
// //     required this.availableSeatsCount,
// //     required this.availableSeats, // Add to constructor
// //     required this.time,
// //     required this.amount,
// //     required this.capacity,
// //     required this.date,
// //     required this.origin,
// //     required this.destination,
// //     this.vehicle,
// //   });

// //   factory TripModel.fromMap(Map<String, dynamic> map) {
// //     // --- FIX: Parse the list of seats and store it ---
// //     List<int> seatsList = [];
// //     if (map['available_seats'] != null && map['available_seats'] is List) {
// //       // Convert the dynamic list [1, 2, 3] to a List<int>
// //       seatsList = (map['available_seats'] as List).map((e) => e as int).toList();
// //     }
// //     // --------------------------------------------------

// //     // Calculate count from the list's length
// //     int seatCount = seatsList.length;

// //     return TripModel(
// //       id: map['id']?.toInt() ?? 0,
// //       availableSeatsCount: seatCount,
// //       availableSeats: seatsList, // Store the actual list
// //       time: map['time'] ?? '',
// //       amount: map['amount']?.toString() ?? '0',
// //       capacity: map['capacity']?.toInt() ?? 0,
// //       date: map['date'] ?? '',
// //       origin: TerminalModel.fromMap(map['origin'] ?? {}),
// //       destination: TerminalModel.fromMap(map['destination'] ?? {}),
// //       vehicle: map['vehicle'] != null ? VehicleModel.fromMap(map['vehicle']) : null,
// //     );
// //   }
// // }
// import 'terminal_model.dart';
// import 'vehicle_model.dart';

// class TripModel {
//   final int id;
//   final int availableSeatsCount;
//   final List<int> availableSeats;
//   final List<int> bookedSeats;
//   final String time;
//   final String amount;
//   final String date;
//   final TerminalModel origin;
//   final TerminalModel destination;
//   final VehicleModel? vehicle;

//   TripModel({
//     required this.id,
//     required this.availableSeatsCount,
//     required this.availableSeats,
//     required this.bookedSeats,
//     required this.time,
//     required this.amount,
//     required this.date,
//     required this.origin,
//     required this.destination,
//     this.vehicle,
//   });

//   factory TripModel.fromMap(Map<String, dynamic> map) {
//     List<int> seatsList = (map['available_seats'] as List? ?? []).map((e) => e as int).toList();
//     List<int> booked = (map['booked_seats'] as List? ?? []).map((e) => e as int).toList();
    
//     return TripModel(
//       id: map['id']?.toInt() ?? 0,
//       availableSeatsCount: seatsList.length,
//       availableSeats: seatsList,
//       bookedSeats: booked,
//       time: map['time'] ?? '',
//       amount: map['amount']?.toString() ?? '0',
//       date: map['date'] ?? '',
//       origin: TerminalModel.fromMap(map['origin'] ?? {}),
//       destination: TerminalModel.fromMap(map['destination'] ?? {}),
//       vehicle: map['vehicle'] != null ? VehicleModel.fromMap(map['vehicle']) : null,
//     );
//   }
// }
import 'terminal_model.dart';
import 'vehicle_model.dart';

class TripModel {
  final int id;
  final int availableSeatsCount;
  final List<int> availableSeats;
  final List<int> bookedSeats;
  final String time;
  final String amount;
  final String date;
  final int capacity; // <-- THIS FIELD WAS MISSING
  final TerminalModel origin;
  final TerminalModel destination;
  final VehicleModel? vehicle;

  TripModel({
    required this.id,
    required this.availableSeatsCount,
    required this.availableSeats,
    required this.bookedSeats,
    required this.time,
    required this.amount,
    required this.date,
    required this.capacity, // <-- ADDED TO CONSTRUCTOR
    required this.origin,
    required this.destination,
    this.vehicle,
  });

  factory TripModel.fromMap(Map<String, dynamic> map) {
    List<int> seatsList = (map['available_seats'] as List? ?? []).map((e) => e as int).toList();
    
    // We don't have a 'booked_seats' field from the API, so we derive it.
    // However, we need the total capacity to do so.
    final int tripCapacity = map['capacity']?.toInt() ?? 0;
    
    final Set<int> allPossibleSeats = List.generate(tripCapacity, (i) => i + 1).toSet();
    final Set<int> availableSeatSet = seatsList.toSet();
    final List<int> calculatedBookedSeats = allPossibleSeats.difference(availableSeatSet).toList();
    
    return TripModel(
      id: map['id']?.toInt() ?? 0,
      availableSeatsCount: seatsList.length,
      availableSeats: seatsList,
      bookedSeats: calculatedBookedSeats, // Use the calculated list
      time: map['time'] ?? '',
      amount: map['amount']?.toString() ?? '0',
      date: map['date'] ?? '',
      capacity: tripCapacity, // <-- ASSIGN THE VALUE HERE
      origin: TerminalModel.fromMap(map['origin'] ?? {}),
      destination: TerminalModel.fromMap(map['destination'] ?? {}),
      vehicle: map['vehicle'] != null ? VehicleModel.fromMap(map['vehicle']) : null,
    );
  }
}