import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/home_screen.dart';

class MainBottomNavController extends GetxController {

  // --- STATE ---
  
  // The currently selected tab index. .obs makes it observable.
  var selectedIndex = 0.obs;
  
  // The list of pages to be displayed in the bottom navigation.
  final List<Widget> pages = [
    HomeScreen(),
    // TODO: Replace with actual screens
    Scaffold(body: Center(child: Text("Trips"))),
    Scaffold(body: Center(child: Text("Track"))),
    Scaffold(body: Center(child: Text("Account"))),
  ];

  // --- ACTIONS ---

  /// Changes the active tab.
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
