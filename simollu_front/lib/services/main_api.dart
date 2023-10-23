import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/main_info_model.dart';
import 'package:simollu_front/models/restaurant_model.dart';
import '../utils/token.dart';

class MainApi {
  late String token; // 'late' 키워드를 사용하여 초기화를 뒤로 미룸

  Future<void> initialize() async {
    token = await getToken(); // getToken() 함수의 반환값을 대입
  }

  Future<MainInfoModel> getRestaurantList(LatLng currentPosition) async {
    await initialize();
    Uri uri = Uri.parse(
        'https://simollu.com/api/restaurant/main/${currentPosition.latitude}/${currentPosition.longitude}');

    final response = await http.get(headers: {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": token
    }, uri);
    if (response.statusCode == 200) {
      List<RestaurantModel> nearBy = [];
      List<dynamic> restaurantNearByList = json.decode(
              utf8.decode(response.bodyBytes))['restaurantNearByList'] ??
          [];
      for (dynamic restaurant in restaurantNearByList) {
        nearBy.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> highRating = [];
      List<dynamic> restaurantHighRatingList = json.decode(
              utf8.decode(response.bodyBytes))['restaurantHighRatingList'] ??
          [];
      for (dynamic restaurant in restaurantHighRatingList) {
        highRating.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> lessWaiting = [];
      List<dynamic> restaurantLessWaitingList = json.decode(
              utf8.decode(response.bodyBytes))['restaurantLessWaitingList'] ??
          [];
      for (dynamic restaurant in restaurantLessWaitingList) {
        lessWaiting.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> korean = [];
      List<dynamic> koreanFoodTopList =
          json.decode(utf8.decode(response.bodyBytes))['koreanFoodTopList'] ??
              [];
      for (dynamic restaurant in koreanFoodTopList) {
        korean.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> western = [];
      List<dynamic> westernFoodTopList =
          json.decode(utf8.decode(response.bodyBytes))['westernFoodTopList'] ??
              [];
      for (dynamic restaurant in westernFoodTopList) {
        western.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> chinese = [];
      List<dynamic> chineseTopList =
          json.decode(utf8.decode(response.bodyBytes))['chineseTopList'] ?? [];
      for (dynamic restaurant in chineseTopList) {
        chinese.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> japanese = [];
      List<dynamic> japaneseTopList =
          json.decode(utf8.decode(response.bodyBytes))['japaneseTopList'] ?? [];
      for (dynamic restaurant in japaneseTopList) {
        japanese.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> fastfood = [];
      List<dynamic> fastFoodTopList =
          json.decode(utf8.decode(response.bodyBytes))['fastFoodTopList'] ?? [];
      for (dynamic restaurant in fastFoodTopList) {
        fastfood.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> cafe = [];
      List<dynamic> cafeTopList =
          json.decode(utf8.decode(response.bodyBytes))['cafeTopList'] ?? [];
      for (dynamic restaurant in cafeTopList) {
        cafe.add(RestaurantModel.fromJSON(restaurant));
      }

      List<RestaurantModel> bakery = [];
      List<dynamic> bakeryTopList =
          json.decode(utf8.decode(response.bodyBytes))['bakeryTopList'] ?? [];
      for (dynamic restaurant in bakeryTopList) {
        bakery.add(RestaurantModel.fromJSON(restaurant));
      }
      return MainInfoModel(
        restaurantNearByList: nearBy,
        restaurantHighRatingList: highRating,
        restaurantLessWaitingList: lessWaiting,
        koreanFoodTopList: korean,
        westernFoodTopList: western,
        chineseTopList: chinese,
        japaneseTopList: japanese,
        fastFoodTopList: fastfood,
        cafeTopList: cafe,
        bakeryTopList: bakery,
      );
    }
    return MainInfoModel(
      restaurantNearByList: [],
      restaurantHighRatingList: [],
      restaurantLessWaitingList: [],
      koreanFoodTopList: [],
      westernFoodTopList: [],
      chineseTopList: [],
      japaneseTopList: [],
      fastFoodTopList: [],
      cafeTopList: [],
      bakeryTopList: [],
    );
  }
}
