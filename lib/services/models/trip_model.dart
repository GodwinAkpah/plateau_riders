// lib/services/models/trip_model.dart
import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';

class TripModel {
  final int id;
  final int remainingSeats;
  final String time; // Departure time
  final String amount;
  final int capacity;
  final String date;
  final TerminalModel origin;
  final TerminalModel destination;
  final VehicleModel vehicle;

  TripModel({
    required this.id,
    required this.remainingSeats,
    required this.time,
    required this.amount,
    required this.capacity,
    required this.date,
    required this.origin,
    required this.destination,
    required this.vehicle,
  });

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map['id']?.toInt() ?? 0,
      remainingSeats: map['remaining_seats']?.toInt() ?? 0,
      time: map['time'] ?? '',
      amount: map['amount'] ?? '0',
      capacity: map['capacity']?.toInt() ?? 0,
      date: map['date'] ?? '',
      origin: TerminalModel.fromMap(map['origin'] ?? {}),
      destination: TerminalModel.fromMap(map['destination'] ?? {}),
      vehicle: VehicleModel.fromMap(map['vehicle'] ?? {}),
    );
  }
}