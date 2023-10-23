import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/services/waiting_api.dart';

import 'package:simollu_front/utils/fcm_setting.dart';
import 'package:simollu_front/utils/firebase_message.dart';
import 'package:simollu_front/utils/firebase_options.dart';
import 'package:simollu_front/utils/token_stamp.dart';
import 'package:simollu_front/viewmodels/main_view_model.dart';
import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/viewmodels/preference_view_model.dart';
import 'package:simollu_front/viewmodels/notification_view_model.dart';
import 'package:simollu_front/viewmodels/restaurant_view_model.dart';
import 'package:simollu_front/viewmodels/review_view_model.dart';
import 'package:simollu_front/viewmodels/search_view_model.dart';
import 'package:simollu_front/viewmodels/user_view_model.dart';
import 'package:simollu_front/viewmodels/waiting_view_model.dart';
import 'package:simollu_front/views/start_page.dart';
import 'package:simollu_front/root.dart';

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // String? firebaseToken = await fcmSetting();
  await dotenv.load(fileName: ".env"); // 추가

  // Set the background messaging handler early on, as a named top-level function
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final firebaseToken = await fcmSetting();
  print(firebaseToken);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  final getToken = TokenStamp();
  getToken.tokenStamp();
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  print(token);

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: '210_Gulim_070'
      ),
      defaultTransition: Transition.cupertino,
      initialBinding: BindingsBuilder(
        () {
          Get.put(RootController());
          Get.put(MainViewModel());
          Get.put(UserViewModel());
          Get.put(MapViewModel());
          Get.put(SearchViewModel());
          Get.put(MainViewModel());
          Get.put(WaitingViewModel());
          Get.put(RestaurantViewModel());
          Get.put(ReviewViewModel());
          Get.put(PreferenceViewModel());
        },
      ),
      // home: Root(),
      home: StartPage(),
    );
  }
}
