
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  String userName = 'Sarah';
  int seats = 4;
  String? fromCity;
  String? toCity;
  DateTime? selectedDate;
  String? vehicleType;

  final List<String> vehicleTypes = ['Car', 'Bus', 'Sienna'];

  void incrementSeats() {
    if (seats < 10) {
      seats++;
      update();
    }
  }

  void decrementSeats() {
    if (seats > 1) {
      seats--;
      update();
    }
  }

  void setFromCity(String city) {
    fromCity = city;
    update();
  }

  void setToCity(String city) {
    toCity = city;
    update();
  }

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    update();
  }

  void setVehicleType(String type) {
    vehicleType = type;
    update();
  }
}
