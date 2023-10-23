import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

Future<String?> fcmSetting() async {
  // firebase core 기능 사용을 위한 필수 initializing
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // foreground에서의 푸시 알림 표시를 위한 알림 중요도 설정 (안드로이드)
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.',
      importance: Importance.max
  );

  // foreground 에서의 푸시 알림 표시를 위한 local notifications 설정
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  // foreground 푸시 알림 핸들링
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    print('Got a message whilst in the foreground!');
    print('Message data: ${notification?.title}');
    print('Message data: ${notification?.body}');

    if (message.notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // icon: android.smallIcon,
            ),
          ));

      if (kDebugMode) {
        print('Message also contained a notification: ${message.notification}');
      }
    }
  });

  AndroidInitializationSettings initializationSettingsAndriod = const AndroidInitializationSettings('mipmap/ic_launcher');

  DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndriod,
      iOS: initializationSettingsIOS
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // firebase token 발급
  String? firebaseToken = await messaging.getToken();

  if (kDebugMode) {
    print("firebaseToken : $firebaseToken");
  }

  return firebaseToken;
}

