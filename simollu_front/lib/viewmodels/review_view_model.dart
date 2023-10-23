import 'dart:convert';

import 'package:get/get.dart';
import 'package:simollu_front/models/reviewModel.dart';
import 'package:simollu_front/utils/token.dart';
import 'package:http/http.dart' as http;

class ReviewViewModel extends GetxController {
  late int restaurantSeq;
  late int reviewRating;
  late String reviewContent;

  RxList<ReviewModel> reviewList = <ReviewModel>[].obs;
  int? reviewSeq;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  // 내 리뷰 작성
  Future<String> postReview(String json) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review');
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      body: json,
    );
    return response.body;
  }

  // 내 리뷰 수정
  Future<void> putReview(String reviewSeq, String json) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/detail/$reviewSeq');
    await http.put(url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": token
        },
        body: json);
  }

  // 내 리뷰 목록 가져오기
  Future<List<ReviewModel>> fetchReviews() async {
    List<ReviewModel> result = [];

    try {
      String token = await getToken();
      print(token);
      var url = createUrl('/restaurant/review');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": token
        },
      );

      final decodedList = jsonDecode(utf8.decode(response.bodyBytes));

      // Test
      // print(decodedList.runtimeType);
      // print((decodedList as List).runtimeType);
      // print(decodedList.map((item) => ReviewModel.fromJson(item)).toList().runtimeType);

      result = (decodedList as List)
          .map((item) => ReviewModel.fromJson(item))
          .toList();
      reviewList.value = result;
      // print(decodedList.map((item) => ReviewModel.fromJson(item)).toList().runtimeType);

    } catch (error) {
      print("Exception caught: $error");
    }

    return result;
  }
}
