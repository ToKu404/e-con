import 'package:e_con/core/services/notif_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotifHelper {
  Future<void> init() async {
    //Remove this method to stop OneSignal Debugging
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.setAppId(NotifService.appId);

    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });

    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print(value!.userId)});
  }

  Future<String?> generateUserAppId() async {
    final status = await OneSignal.shared.getDeviceState();
    print(status?.userId);
    return status?.userId;
  }
}
