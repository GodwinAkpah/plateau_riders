// lib/services/models/vehicle_model.dart

class VehicleModel {
  final int id;
  final String regNo;
  final String name;
  final String type;
  final int capacity;

  VehicleModel({
    required this.id,
    required this.regNo,
    required this.name,
    required this.type,
    required this.capacity,
  });

  factory VehicleModel.fromMap(Map<String, dynamic> map) {
    return VehicleModel(
      id: map['id']?.toInt() ?? 0,
      regNo: map['reg_no'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      capacity: map['capacity']?.toInt() ?? 0,
    );
  }
}