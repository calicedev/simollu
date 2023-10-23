import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/menuInfoModel.dart';
import 'package:simollu_front/models/restaurantDetailModel.dart';
import 'package:simollu_front/models/restaurantInfoModel.dart';
import 'package:simollu_front/models/restaurantReviewModel.dart';
import 'package:simollu_front/models/waitingTimeModel.dart';
import 'package:simollu_front/models/waiting_info_model.dart';
import 'package:simollu_front/services/restaurant_detail_api.dart';
import 'package:simollu_front/utils/token.dart';

class RestaurantViewModel extends GetxController {
  Rx<RestaurantDetailModel?> restaurant = Rx<RestaurantDetailModel?>(null);
  Rx<RestaurantInfoModel?> restaurantInfo = Rx<RestaurantInfoModel?>(null);
  RxList<MenuInfoModel> menuInfoList = <MenuInfoModel>[].obs;
  RxList<WaitingTimeModel> waitingTimeList = <WaitingTimeModel>[].obs;
  RxList<RestaurantReviewModel> reviews = <RestaurantReviewModel>[].obs;
  late String token;

  Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  // 식당 상세정보 조회
  Future<void> fetchRestaurantDetail(int restaurantSeq) async {
    RestaurantDetailModel? res =
        await RestaurantDetailApi().getRestaurantDetailInfo(restaurantSeq);
    if (res != null) {
      restaurantInfo.value = res.restaurantInfo;
      menuInfoList.value = res.menuInfoList;
      waitingTimeList.value = res.waitingTimeList;
    } else {
      restaurantInfo.value = null;
      menuInfoList.value = [];
      waitingTimeList.value = [];
    }
  }

  // 식당 리뷰들 조회
  Future<void> fetchReview(int restaurantSeq) async {
    String token = await getToken();
    Uri uri =
        Uri.parse('https://simollu.com/api/restaurant/review/${restaurantSeq}');

    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );
    List<RestaurantReviewModel> result = [];

    print('가게 리뷰 리스트 조회 : ');
    if (response.statusCode == 200) {
      List<dynamic> res = json.decode(utf8.decode(response.bodyBytes));
      for (dynamic r in res) {
        result.add(RestaurantReviewModel.fromJson(r));
        print(r);
      }
      reviews.value = result;
    }

    // final testjsonList = json.decode(response.body);
    // List<RestaurantReviewModel> reviewList = testjsonList
    //     .map((json) => RestaurantReviewModel.fromJson(json))
    //     .toList();
    //
    // final jsonList = jsonDecode(utf8.decode(response.bodyBytes));
    // // final jsonList = jsonDecode(utf8.decode(response.bodyBytes));
    // List<Map<String, dynamic>> result = jsonList
    //     .map<Map<String, dynamic>>((review) => review as Map<String, dynamic>)
    //     .toList();
    //
  }

  // 개별 리뷰 조회
  Future<RestaurantReviewModel> fetchReviewDetail(int reviewSeq) async {
    String token = await getToken();
    var url = createUrl('/restaurant/review/detail/$reviewSeq');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    RestaurantReviewModel review = RestaurantReviewModel.fromJson(jsonData);
    return review;
  }
}
