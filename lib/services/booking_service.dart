// import 'package:get/get.dart';
// import 'package:plateau_riders/services/core_service.dart';
// import 'package:plateau_riders/services/models/api_response_T.dart';
// import 'package:plateau_riders/services/models/terminal_model.dart';
// import 'package:plateau_riders/services/models/trip_model.dart';
// import 'package:plateau_riders/services/models/vehicle_model.dart';

// class BookingService extends GetxService {
//   final CoreService _coreService = Get.find<CoreService>();

//   Future<APIResponse<List<TerminalModel>>> getTerminals({String? search}) async {
//     final Map<String, dynamic> params = {'page': 1};
//     if (search != null && search.isNotEmpty) {
//       params['search'] = search;
//     }

//     final response = await _coreService.fetch('/terminals', params: params);

//     if (response.status == "success" && response.data?['data'] is List) {
//       final List<dynamic> terminalList = response.data['data'];
//       final parsedTerminals =
//           terminalList.map((e) => TerminalModel.fromMap(e)).toList();
//       return APIResponse(
//           status: "success", message: response.message, data: parsedTerminals);
//     }
//     return APIResponse(
//         status: response.status, message: response.message, data: []);
//   }

//   Future<APIResponse<List<VehicleModel>>> getVehicles() async {
//     final response = await _coreService.fetch('/vehicles');

//     if (response.status == "success" && response.data?['data'] is List) {
//       final List<dynamic> vehicleList = response.data['data'];
//       final parsedVehicles =
//           vehicleList.map((e) => VehicleModel.fromMap(e)).toList();
//       return APIResponse(
//           status: "success", message: response.message, data: parsedVehicles);
//     }
//     return APIResponse(
//         status: response.status, message: response.message, data: []);
//   }

//   Future<APIResponse<List<TripModel>>> searchTrips({
//     required String date, // "YYYY-MM-DD"
//     required int originId,
//     required int destinationId,
//   }) async {
//     final params = {
//       'date': date,
//       'origin_id': originId,
//       'destination_id': destinationId,
//     };

//     final response = await _coreService.fetch('/trips', params: params);

//     if (response.status == "success" && response.data?['data'] is List) {
//       final List<dynamic> tripList = response.data['data'];
//       final parsedTrips = tripList.map((e) => TripModel.fromMap(e)).toList();
//       return APIResponse(
//           status: "success", message: response.message, data: parsedTrips);
//     }
//     return APIResponse(
//         status: response.status, message: response.message, data: []);
//   }

//   Future<APIResponse<dynamic>> bookTrip({
//     required String customerName,
//     required String customerEmail,
//     required String customerPhone,
//     required String customerGender,
//     required String customerNextOfKin,
//     required String customerNextOfKinPhone,
//     required int seatNo, // Changed to a single seat for now, per your Postman
//     required int tripId,
//     required Map<String, dynamic> payment,
//   }) async {
//     final payload = {
//       "customer_name": customerName,
//       "customer_email": customerEmail,
//       "customer_phone": customerPhone,
//       "customer_gender": customerGender,
//       "customer_next_of_kin": customerNextOfKin,
//       "customer_next_of_kin_phone": customerNextOfKinPhone,
//       "seat_no": seatNo,
//       "trip_id": tripId,
//       "source": "mobile_admin",
//       "payment": payment,
//     };

//     // Get the original response from the CoreService.
//     final coreResponse = await _coreService.send('/bookings', payload);

//     // Create and return a new instance of the generic APIResponse<dynamic>,
//     // transferring the values from the original response. This resolves the type mismatch.
//     return APIResponse<dynamic>(
//       status: coreResponse.status,
//       message: coreResponse.message,
//       data: coreResponse.data,
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:plateau_riders/services/core_service.dart';
import 'package:plateau_riders/services/models/api_response_T.dart';
import 'package:plateau_riders/services/models/terminal_model.dart';
import 'package:plateau_riders/services/models/trip_model.dart';
import 'package:plateau_riders/services/models/vehicle_model.dart';

class BookingService extends GetxService {
  // --- FIX: The CoreService is now a final field, received from the outside ---
  final CoreService _coreService;

  // --- FIX: This is the constructor that was missing ---
  BookingService(this._coreService);

  Future<APIResponse<List<TerminalModel>>> getTerminals({String? search}) async {
    final Map<String, dynamic> params = {'page': 1};
    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }

    final response = await _coreService.fetch('/terminals', params: params);

    if (response.status == "success" && response.data?['data'] is List) {
      final List<dynamic> terminalList = response.data['data'];
      final parsedTerminals =
          terminalList.map((e) => TerminalModel.fromMap(e)).toList();
      return APIResponse(
          status: "success", message: response.message, data: parsedTerminals);
    }
    return APIResponse(
        status: response.status, message: response.message, data: []);
  }

  Future<APIResponse<List<VehicleModel>>> getVehicles() async {
    final response = await _coreService.fetch('/vehicles');

    if (response.status == "success" && response.data?['data'] is List) {
      final List<dynamic> vehicleList = response.data['data'];
      final parsedVehicles =
          vehicleList.map((e) => VehicleModel.fromMap(e)).toList();
      return APIResponse(
          status: "success", message: response.message, data: parsedVehicles);
    }
    return APIResponse(
        status: response.status, message: response.message, data: []);
  }

  Future<APIResponse<List<TripModel>>> searchTrips({
    required String date, // "YYYY-MM-DD"
    required int originId,
    required int destinationId,
  }) async {
    final params = {
      'date': date,
      'origin_id': originId,
      'destination_id': destinationId,
    };

    final response = await _coreService.fetch('/trips', params: params);

    if (response.status == "success" && response.data?['data'] is List) {
      final List<dynamic> tripList = response.data['data'];
      final parsedTrips = tripList.map((e) => TripModel.fromMap(e)).toList();
      return APIResponse(
          status: "success", message: response.message, data: parsedTrips);
    }
    return APIResponse(
        status: response.status, message: response.message, data: []);
  }

  Future<APIResponse<dynamic>> bookTrip({
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String customerGender,
    required String customerNextOfKin,
    required String customerNextOfKinPhone,
    required int seatNo,
    required int tripId,
    required Map<String, dynamic> payment,
  }) async {
    final payload = {
      "customer_name": customerName,
      "customer_email": customerEmail,
      "customer_phone": customerPhone,
      "customer_gender": customerGender,
      "customer_next_of_kin": customerNextOfKin,
      "customer_next_of_kin_phone": customerNextOfKinPhone,
      "seat_no": seatNo,
      "trip_id": tripId,
      "source": "mobile_admin",
      "payment": payment,
    };
    
    final coreResponse = await _coreService.send('/bookings', payload);

    return APIResponse<dynamic>(
      status: coreResponse.status,
      message: coreResponse.message,
      data: coreResponse.data,
    );
  }
}