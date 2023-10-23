import 'dart:convert';

import 'package:simollu_front/models/writeableModel.dart';
import 'package:simollu_front/utils/token.dart';
import 'package:http/http.dart' as http;

class WriteableViewModel {
  late int writeableSeq;
  late String userSeq;
  late int restaurantSeq;
  late String waitingCompleteDate;
  late String restaurantName;
  late String restaurantImg;

  static Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  // 작성 가능 리뷰 목록 가져오기
  static Future<List<WriteableModel>> fetchReviews() async {
    List<WriteableModel> result = [];
    String token = await getToken();
    var url = createUrl('/restaurant/review/writeable');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    if (response.statusCode == 200) {
      final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
      result = (decodedList as List).map((item) =>
        WriteableModel.fromJson(item)).toList();
    } else if (response.statusCode == 202) {

    } else {
      throw Error();
    }
    print(result);
    return result;
  }
}
