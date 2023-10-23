
// 앱이 켜질때 아니면, 로그인할 때마다 fcmToken + jwtToken 보내주기

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

String? jwtToken = '';
String? fcmToken = '';

class TokenStamp {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> tokenStamp() async{
    final SharedPreferences prefs = await _prefs;
    jwtToken = prefs.getString('token') ?? '';
    if (jwtToken != '') {
      getFcmToken().then((value) => {
        setFcmToken(jwtToken, value)
      });
    }
  }

  Future<String?> getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }

  void tokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) async {
      // TODO: If necessary send token to application server.
      try {
        final SharedPreferences prefs = await _prefs;
        if (prefs.getString('token') != null) {
          fcmToken = prefs.getString('token')!;
          await tokenStamp();
        }
      } catch(e) {
        throw Error();
      }
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    })
        .onError((err) {
      // Error getting token.
    });
  }

  void setFcmToken(String? jwt, String? fcm) async {
    Uri url = Uri.parse('https://simollu.com/api/user/user/firebase-token');
    await http.post(url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": jwt!
        },
        body: jsonEncode({
          'fcmToken': fcm
        })
    );
  }
}
