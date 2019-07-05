import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationReceiver {
  void onNotification(Map<dynamic, dynamic> message);
}

abstract class FCMToken {
  void onToken(String token);
}

class NotificationUtil {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  NotificationReceiver service;
  FCMToken fcmToken;
  NotificationUtil({this.service});
  NotificationUtil.onToken({this.fcmToken});

  permission() {
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  openDialogConfirm(Map<dynamic, dynamic> message) {
    service.onNotification(message);
  }

  init() {
    permission();
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
       openDialogConfirm(message);
      },
      onResume: (Map<String, dynamic> message) {
        openDialogConfirm(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        openDialogConfirm(message);
      },
    );
  }

  getToken() {
    permission();
    firebaseMessaging.getToken().then((token) {
      fcmToken.onToken(token);
    });
  }
}
