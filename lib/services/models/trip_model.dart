import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';

class TripModel {
  final int id;
  final int availableSeatsCount;
  // --- FIX: Add a property to store the actual list of seat numbers ---
  final List<int> availableSeats;
  // -----------------------------------------------------------------
  final String time;
  final String amount;
  final int capacity;
  final String date;
  final TerminalModel origin;
  final TerminalModel destination;
  final VehicleModel? vehicle;

  TripModel({
    required this.id,
    required this.availableSeatsCount,
    required this.availableSeats, // Add to constructor
    required this.time,
    required this.amount,
    required this.capacity,
    required this.date,
    required this.origin,
    required this.destination,
    this.vehicle,
  });

  factory TripModel.fromMap(Map<String, dynamic> map) {
    // --- FIX: Parse the list of seats and store it ---
    List<int> seatsList = [];
    if (map['available_seats'] != null && map['available_seats'] is List) {
      // Convert the dynamic list [1, 2, 3] to a List<int>
      seatsList = (map['available_seats'] as List).map((e) => e as int).toList();
    }
    // --------------------------------------------------

    // Calculate count from the list's length
    int seatCount = seatsList.length;

    return TripModel(
      id: map['id']?.toInt() ?? 0,
      availableSeatsCount: seatCount,
      availableSeats: seatsList, // Store the actual list
      time: map['time'] ?? '',
      amount: map['amount']?.toString() ?? '0',
      capacity: map['capacity']?.toInt() ?? 0,
      date: map['date'] ?? '',
      origin: TerminalModel.fromMap(map['origin'] ?? {}),
      destination: TerminalModel.fromMap(map['destination'] ?? {}),
      vehicle: map['vehicle'] != null ? VehicleModel.fromMap(map['vehicle']) : null,
    );
  }
}