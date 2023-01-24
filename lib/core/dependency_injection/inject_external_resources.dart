import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/helpers/notif_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

void injectExternalResources(GetIt locator) {
  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => http.Client());

  // external
  locator.registerLazySingleton<AuthPreferenceHelper>(
      () => AuthPreferenceHelper());

  // one signal
  locator.registerLazySingleton<NotifHelper>(() => NotifHelper());
}
