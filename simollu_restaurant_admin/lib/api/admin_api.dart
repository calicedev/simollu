import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_restaurant_admin/model/waiting_user_model.dart';

class AdminApi {

  // [GET] 가게 웨이팅 리스트 가져오기
  Future<List<WaitingUserModel>> getWaitingList() async {
    Uri uri = Uri.parse('https://simollu.com/api/waiting/restaurant/124');
    List<WaitingUserModel> result = [];

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0M2NjY2U5Yi03MjEwLTRjN2MtYTQzYi1kZWQzOGExZmQxYjUiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4NDY0Mjc0OX0.TJ4uXyI0iMQgYywX7cfpeQZeg5RWGQu887Wj-h9SU-8"
        },
        uri);

    print(response.body);
    if (response.statusCode == 200) {

      List<dynamic> res = json.decode(utf8.decode(response.bodyBytes));
      print("웨이팅 리스트 조회 연결 :");
      for(dynamic r in res) {
        result.add(WaitingUserModel.fromJSON(r));
        print(r);
      }
    }

    return result;
  }

  // [POST] user에게 입장 알림 보내기
  Future<bool> postSendAlarm(String targetUserSeq) async {
    Uri uri = Uri.parse('https://simollu.com/api/alert/alert');

    final response = await http.post(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0M2NjY2U5Yi03MjEwLTRjN2MtYTQzYi1kZWQzOGExZmQxYjUiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4NDY0Mjc0OX0.TJ4uXyI0iMQgYywX7cfpeQZeg5RWGQu887Wj-h9SU-8"
        },
        body: json.encode({
          "targetUserSeq" : targetUserSeq,
          "title": "입장 알림",
          "body": "입장하실 차례에요. 가게 앞에 5분 내로 와주세요.",
          "code" :"COME_IN_PLEASE"
        }), uri);

    print(response.statusCode);
    print("post @@@@@" + response.body);

    if (response.statusCode == 200) {

      return true;
    }
    return false;
  }

  // [POST] user 입장 완료 처리
  Future<bool> postWaitingComplete(int waitingSeq, String userSeq) async{
    Uri uri = Uri.parse('https://simollu.com/api/waiting/restaurant/complete');

    final response = await http.post(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0M2NjY2U5Yi03MjEwLTRjN2MtYTQzYi1kZWQzOGExZmQxYjUiLCJhdXRob3JpdHkiOlsiUk9MRV9VU0VSIl0sImV4cCI6MTY4NDY0Mjc0OX0.TJ4uXyI0iMQgYywX7cfpeQZeg5RWGQu887Wj-h9SU-8"
        },
        body: json.encode({
          "waitingSeq" : waitingSeq,
          "userSeq": userSeq
        }), uri);

    print(response.statusCode);
    print("post @@@@@" + response.body);

    if (response.statusCode == 200) {

      return true;
    }
    return false;
  }
}