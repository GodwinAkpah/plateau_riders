import 'package:plateau_riders/services/models/trip_model.dart';
import 'package:plateau_riders/services/models/user_model.dart';

class BookingModel {
  final int id;
  final int seatNo;
  final String refNo;
  final String createdAt;
  final TripModel trip;
  final UserModel user; // The customer who booked

  BookingModel({
    required this.id,
    required this.seatNo,
    required this.refNo,
    required this.createdAt,
    required this.trip,
    required this.user,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id']?.toInt() ?? 0,
      seatNo: map['seat_no']?.toInt() ?? 0,
      refNo: map['ref_no'] ?? '',
      createdAt: map['created_at'] ?? '',
      trip: TripModel.fromMap(map['trip'] ?? {}),
      user: UserModel.fromMap(map['user'] ?? {}),
    );
  }
}