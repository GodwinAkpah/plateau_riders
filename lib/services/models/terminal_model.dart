// lib/services/models/terminal_model.dart
import 'dart:convert';

class LocationModel {
  final int id;
  final String name;
  final String latitude;
  final String longitude;

  LocationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
    );
  }
}

class TerminalModel {
  final int id;
  final String name;
  final String openingTime;
  final String closingTime;
  final List<LocationModel> locations;

  TerminalModel({
    required this.id,
    required this.name,
    required this.openingTime,
    required this.closingTime,
    required this.locations,
  });

  factory TerminalModel.fromMap(Map<String, dynamic> map) {
    var locationsList = <LocationModel>[];
    if (map['locations'] != null && map['locations'] is List) {
      locationsList = (map['locations'] as List)
          .map((loc) => LocationModel.fromMap(loc))
          .toList();
    }

    return TerminalModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      openingTime: map['opening_time'] ?? '',
      closingTime: map['closing_time'] ?? '',
      locations: locationsList,
    );
  }
}