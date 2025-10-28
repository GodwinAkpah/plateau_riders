
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package.get_storage/get_storage.dart';
import 'package:plateau_riders/providers/auth_provider.dart';
import 'package:plateau_riders/routing/app_pages.dart';
import 'package:plateau_riders/services/service_manifest.dart';
import 'package:get_storage/get_storage.dart'; // <-- 1. IMPORTED SERVICE MANIFEST

// GlobalKey is good practice for certain advanced navigation scenarios.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // Ensure all async operations are complete before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();

  // --- FIX IS HERE ---
  setupServiceLocator(); // <-- 2. INITIALIZE YOUR SERVICES
  // -------------------

  // Your AuthProvider init can stay if it's part of a separate system.
  await AuthProvider().init();

  // Set preferred device orientation.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();

  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  runApp(PlateauRidersApp(navigatorKey: navigatorKey));
}

class PlateauRidersApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const PlateauRidersApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plateau Riders',
      themeMode:
          (GetStorage().read('isDarkMode') ?? false)
              ? ThemeMode.dark
              : ThemeMode.light,
     
      initialRoute: AppPages.initial, // Tells GetX which route to load first.
      getPages: AppPages.routes, // Provides all the routes and their bindings.
      navigatorKey: navigatorKey,
      // The 'home' property is removed because initialRoute is the correct way.
    );
  }
}
