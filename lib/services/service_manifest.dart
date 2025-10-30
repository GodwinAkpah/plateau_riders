import 'package:get/get.dart';
import 'package:plateau_riders/services/auth/authentication_service.dart';

import 'package:plateau_riders/services/booking_service.dart';
import 'package:plateau_riders/services/core_service.dart';

/// Initializes and registers all application-level services using GetX's dependency injection.
/// This function should be called once in your main.dart file before the app runs.
void setupServiceLocator() {
  
  // --- Step 1: Create the CoreService instance first ---
  // This is the dependency that other services need.
  final CoreService coreService = CoreService();

  // --- Step 2: Register CoreService with GetX ---
  // We use `Get.put` to make it available to the rest of the app via `Get.find()`.
  Get.put<CoreService>(coreService, permanent: true);

  // --- Step 3: Register the other services and pass the instance directly ---
  // Instead of using Get.find(), we pass the `coreService` variable we just created.
  // This is a more direct and reliable way to handle dependencies during setup.
  
  // Register AuthenticationService, providing it with the coreService instance.
  Get.put<AuthenticationService>(AuthenticationService(coreService), permanent: true);

  // Register BookingService, also providing it with the coreService instance.
  Get.put<BookingService>(BookingService(coreService), permanent: true);
}