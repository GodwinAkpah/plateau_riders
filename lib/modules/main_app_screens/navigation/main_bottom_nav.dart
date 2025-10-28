import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plateau_riders/modules/app_colors/plateau_colors.dart';
import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav_controllers.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      init: MainBottomNavController(),
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.trip_origin),
                label: 'Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.track_changes),
                label: 'Track',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Account',
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: PlateauColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: controller.changeTabIndex,
          ),
        );
      },
    );
  }
}
