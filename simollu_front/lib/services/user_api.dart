import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simollu_front/models/restaurant_model.dart';
import 'package:simollu_front/models/reviewModel.dart';
import 'package:simollu_front/utils/token.dart';

class UserAPI {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸
  final Uri baseUrl = Uri.parse("https://simollu.com");

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<List<RestaurantModel>> getInterestRestaurants() async {
    await initialize();
    Uri url = baseUrl.resolve("/api/user/user/restaurant-list");

    final response = await http.get(
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      url,
    );

    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));

      List<RestaurantModel> restaurantList = [];

      for (dynamic r in responseBody) {
        restaurantList.add(RestaurantModel.fromJSON(r));
      }

      return restaurantList;
    }

    return [];
  }

  Future<List<ReviewModel>> getReviews() async {
    await initialize();
    Uri url = baseUrl.resolve("/api/restaurant/review");
    final response = await http.get(
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      url,
    );
    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(utf8.decode(response.bodyBytes));

      List<ReviewModel> reviewList = [];

      for (dynamic r in responseBody) {
        reviewList.add(ReviewModel.fromJson(r));
      }
      return reviewList;
    }
    return [];
  }

  Future<bool> postInterestRestaurant(int restaurantSeq) async {
    await initialize();
    Uri url = baseUrl.resolve('/api/user/user/restaurant');

    final response = await http.post(
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
      url,
      body: json.encode({
        'restaurantSeq': restaurantSeq,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
