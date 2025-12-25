//ref:
// https://developer.apple.com/documentation/uikit/uiapplication/unregisterforremotenotifications()
//https://pub.dev/packages/push
import 'dart:async';
import 'package:m360_app_corpsec/helpers/shareFunc.dart';
import 'package:m360_app_corpsec/helpers/utils.dart';
import 'package:push/push.dart';

class PushHelper {
  static final bool _debug = false;
  static String fcmToken = "-";
  static List<RemoteMessage> messagesReceived = [];
  static Function? unsubOnNewToken;
  static Function? unsubOnMessage;
  static Function? unsubOnBackgroundMessage;
  static Function? unsubOnNotificationTap;

  static Future<void> init() async {
    fcmToken = await Push.instance.token ?? "-";

    //await StoreHelper.write(StoreKey.PREF_FCM_TOKEN, _fcmToken);

    unsubOnNewToken = Push.instance.addOnNewToken((token) {
      Utils.log("Just got a new FCM registration token: $token");
    });

    unsubOnMessage = Push.instance.addOnMessage((message) {
      _debug
          ? Utils.log('RemoteMessage received while app is in foreground:\n'
              'RemoteMessage.Notification: ${message.notification} \n'
              ' title: ${message.notification?.title.toString()}\n'
              ' body: ${message.notification?.body.toString()}\n'
              'RemoteMessage.Data: ${message.data}')
          : null;

      messagesReceived.add(message);
      ShareFunc.showToast(
          "title: ${message.notification?.title.toString()} \n body: ${message.notification?.body.toString()}");
    });

    unsubOnBackgroundMessage = Push.instance.addOnBackgroundMessage((message) {
      _debug
          ? Utils.log('RemoteMessage received while app is in background:\n'
              'RemoteMessage.Notification: ${message.notification} \n'
              ' title: ${message.notification?.title.toString()}\n'
              ' body: ${message.notification?.body.toString()}\n'
              'RemoteMessage.Data: ${message.data}')
          : null;

      messagesReceived.add(message);
    });

    unsubOnNotificationTap = Push.instance.addOnNotificationTap((data) {
      _debug ? Utils.log('Notification was tapped:\n' 'Data: $data \n') : null;
    });

    Push.instance.notificationTapWhichLaunchedAppFromTerminated.then((data) {
      if (data == null) {
        _debug ? Utils.log("App was not launched by tapping a notification") : null;
      } else {
        _debug
            ? Utils.log('Notification tap launched app from terminated state:\n'
                'RemoteMessage: $data \n')
            : null;
      }
    });

    //Push.instance.unregisterForRemoteNotifications();
    Push.instance.registerForRemoteNotifications();

    //loynote: register _fcmToken to db in _afterLogin
    //await registerDeviceToken(_fcmToken);
  }

  static Future<void> dispose() async {
    unsubOnNewToken?.call();
    unsubOnMessage?.call();
    unsubOnBackgroundMessage?.call();
    unsubOnNotificationTap?.call();
  }
}
