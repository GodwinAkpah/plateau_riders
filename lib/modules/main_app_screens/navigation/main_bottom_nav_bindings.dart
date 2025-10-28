import 'package:plateau_riders/modules/main_app_screens/navigation/main_bottom_nav_controllers.dart';
import 'package:plateau_riders/modules/main_app_screens/screens/home_screen/controllers/home_controller.dart';

// import 'package:plateau_riders/modules/onboarding/onboarding_data/onboarding_data_controller.dart';
import 'package:get/get.dart';

class MainBottomNavBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainBottomNavController>(() => MainBottomNavController());
    // These are the controllers for each of your tab screens
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<AddServicesController>(() => AddServicesController());
    // Get.lazyPut<MyVendorsController>(() => MyVendorsController());

    // --- THIS IS THE FIX ---

    // Get.lazyPut<OnboardingDataController>(() => OnboardingDataController());
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
