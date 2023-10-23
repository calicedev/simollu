import 'package:simollu_front/models/restaurant_model.dart';

class MainInfoModel {
  final List<RestaurantModel> restaurantNearByList;
  final List<RestaurantModel> restaurantHighRatingList;
  final List<RestaurantModel> restaurantLessWaitingList;
  final List<RestaurantModel> koreanFoodTopList;
  final List<RestaurantModel> westernFoodTopList;
  final List<RestaurantModel> chineseTopList;
  final List<RestaurantModel> japaneseTopList;
  final List<RestaurantModel> fastFoodTopList;
  final List<RestaurantModel> cafeTopList;
  final List<RestaurantModel> bakeryTopList;

  MainInfoModel({
    required this.restaurantNearByList,
    required this.restaurantHighRatingList,
    required this.restaurantLessWaitingList,
    required this.koreanFoodTopList,
    required this.westernFoodTopList,
    required this.chineseTopList,
    required this.japaneseTopList,
    required this.fastFoodTopList,
    required this.cafeTopList,
    required this.bakeryTopList,
  });
}
