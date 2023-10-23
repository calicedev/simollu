import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:simollu_front/models/notification_model.dart';
import 'package:simollu_front/utils/token.dart';
import 'package:http/http.dart' as http;

class NotificationViewModel {
  late int alertSeq;
  late String userSeq;
  late String alertTitle;
  late String alertContent;
  late String alertRegistDate;
  late bool alertIsRead;

  static Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  // 알림 리스트 조회
  Future<List<NotificationModel>> fetchAlerts() async {
    List<NotificationModel> result = <NotificationModel>[];
    String token = await getToken();
    var url = createUrl('/alert/user/alert');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      print('리스트 조회');
      print(response.body);
      final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
      // final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
      result = (decodedList as List).map((item) => NotificationModel.fromJson(item)).toList();
    } else if (response.statusCode == 204) {
    } else {
      print(response.printError);
    }
    // final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
    // result = (decodedList as List).map((item) => NotificationModel.fromJson(item)).toList();
    return result;
  }

  // 알림 읽음 처리
  Future<void> processIsRead(List<NotificationModel> alerts) async {
    String token = await getToken();
    var url = createUrl('/alert/user/alert');

    int alertLength = alerts.length;
    int endSeq = alertLength - 1;
    int startSeq = 0;
    for (int i = endSeq; -1 < i ; i--) {
      if (alerts[i].alertIsRead! == true) {
        startSeq = i+1;
      }
    }

    if (endSeq <= startSeq) return;


    final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": token
        },
        body: jsonEncode(
            {
              "startSeq" : startSeq,
              "endSeq" : endSeq
            }
        )
    );
  }
}