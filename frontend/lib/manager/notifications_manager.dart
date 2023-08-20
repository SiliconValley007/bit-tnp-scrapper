import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _handleBackgroundMessage(RemoteMessage message) async {
  log("Background message: ${message.data}");
}

void _onMessage(RemoteMessage message) {
  log("Foreground message: ${message.data}");
}

abstract class NotificationsManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initNotifications() async {
    final settings = await _firebaseMessaging.requestPermission();
    log(settings.authorizationStatus.toString());
    final fcmToken = await _firebaseMessaging.getToken();
    log('token: ${fcmToken.toString()}');
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
  }
}
