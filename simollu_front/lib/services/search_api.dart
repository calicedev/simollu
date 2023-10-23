import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/search_hot_keyword_model.dart';
import 'package:simollu_front/utils/token.dart';

class SearchApi {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<List<SearchHotKeywordModel>> getHotKeywordList() async {
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/restaurant/search/top-search-keyword');
    List<SearchHotKeywordModel> list = [];

    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
        uri);

    if (response.statusCode == 200) {

      List<dynamic> res = json.decode(utf8.decode(response.bodyBytes));
      print("인기 검색어 api 통신결과 :");
      for(dynamic r in res) {
        list.add(SearchHotKeywordModel.fromJson(r));
        print(r);
      }
      // print(list);
      // print("result :" + jsonDecode(response.body)["result"]);
    }

    return list;
  }
}