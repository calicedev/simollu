import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/searchModel.dart';
import 'package:simollu_front/models/search_hot_keyword_model.dart';
import 'package:simollu_front/services/search_api.dart';
import 'package:simollu_front/utils/token.dart';

class SearchViewModel extends GetxController {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  // 인기검색어 상태 등록
  RxList<SearchHotKeywordModel> hotKeywordList = <SearchHotKeywordModel>[].obs;

  void getHotKeywordList() async{
    List<SearchHotKeywordModel> list = await SearchApi().getHotKeywordList();
    hotKeywordList(list);
  }

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  List<SearchModel> _result = [];

  List<SearchModel> get result => _result;

  Future<void> setSearchResult(List<SearchModel> searchResult) async {
    _result = searchResult;
  }

  // search/contains/?description={검색어}&cx={경도}&cy={위도}&size=10
  String keyword = "베트남음식"; // 검색어
  double lat = 37.5013068; // 현재위치 : 위도
  double long = 127.0396597; // 현재위치 : 경도

  Future<List<SearchModel>> getSearchResult(String value) async {
    await initialize();
    Uri uri = Uri.parse('https://simollu.com/api/restaurant/search/contains?description=${value}&lat=${lat.toString()}&lon=${long.toString()}&size=10');
    List<SearchModel> result = [];
    final response = await http.get(
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization" : token
        },
      uri);
    print("---------@@@@@"+response.body);

    if (response.statusCode == 200) {
      // Map decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // print("decodeResponse");
      // print(decodedResponse);

      List<dynamic> res = json.decode(utf8.decode(response.bodyBytes))["result"];
      // List uri = Uri.parse(decodedResponse['result'] as String) as List;
      // print('uri :');
      // print(uri);
      // result = jsonDecode(response.body)["result"].map<SearchModel>( (result) {
      //   return SearchModel.fromMap(result);
      // }).toList();

      print("검색 결과 :");
      for(dynamic r in res) {
        result.add(SearchModel.fromJSON(r));
        print(r);
      }
      // print("result :" + jsonDecode(response.body)["result"]);
    }

    return result;
  }
}