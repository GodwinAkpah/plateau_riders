import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/bookings_list/bookings_view.dart';

import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/home_screen.dart';

class MainBottomNavController extends GetxController {
  // The currently selected tab index. .obs makes it observable.
  var selectedIndex = 0.obs;

  // The list of pages to be displayed in the bottom navigation.
  final List<Widget> pages = [
    // Tab 0: Home
    const HomeScreen(),
    
    // --- THIS IS THE FIX ---
    // Tab 1: Trips (Now correctly points to our BookingsListView)
    const BookingsListView(),
    // -----------------------
    
    // Tab 2: Track (Placeholder)
    Scaffold(
      appBar: AppBar(title: const Text("Track a Trip")),
      body: const Center(child: Text("Track Screen")),
    ),
    
    // Tab 3: Account (Placeholder)
    Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: const Center(child: Text("Account Screen")),
    ),
  ];

  /// Changes the active tab when a user taps an icon.
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}