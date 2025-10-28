
import 'package:get_it/get_it.dart';
import 'package:plateau_riders/services/auth/auth_service.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(),
  );
 
  // serviceLocator.registerLazySingleton<ProfileService>(() => ProfileService());
  // serviceLocator.registerLazySingleton<DeliveryService>(() => DeliveryService());
  // serviceLocator.registerLazySingleton<WalletsService>(() => WalletsService());

  // serviceLocator.registerLazySingleton<User>(() => UserImpl());
}
