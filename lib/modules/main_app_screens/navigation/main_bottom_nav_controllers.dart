import 'package:get/get.dart';

class MainBottomNavController extends GetxController {

  // --- STATE ---
  
  // The currently selected tab index. .obs makes it observable.
  var selectedIndex = 0.obs;
  
  // The flag that controls the VendorHomeScreen's content. .obs makes it observable.
  // var vendorHasServices = false.obs;

  // --- ACTIONS ---

  /// Changes the active tab.
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  /// This function is called from AddServiceScreen when a new service is added.
//   void onServiceAdded() {
//     vendorHasServices.value = true;
//     // We don't need to call update() because .obs variables update automatically.
//   }

}