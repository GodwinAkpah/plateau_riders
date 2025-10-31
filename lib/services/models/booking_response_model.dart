class BookingResponseModel {
  final int id;
  final String refNo;
  final int seatNo;
  final int tripId;

  BookingResponseModel({
    required this.id,
    required this.refNo,
    required this.seatNo,
    required this.tripId,
  });

  factory BookingResponseModel.fromMap(Map<String, dynamic> map) {
    return BookingResponseModel(
      id: map['id']?.toInt() ?? 0,
      refNo: map['ref_no'] ?? '',
      seatNo: map['seat_no']?.toInt() ?? 0,
      tripId: map['trip_id']?.toInt() ?? 0,
    );
  }
}