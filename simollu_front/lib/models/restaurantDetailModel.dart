// restaurantInfo -> RestaurantInfoModel
// menuInfo -> MenuInfoModel
// waitingTimeList -> WaitingTimeModel

import 'package:simollu_front/models/restaurantInfoModel.dart';
import 'package:simollu_front/models/waitingTimeModel.dart';
import 'menuInfoModel.dart';

class RestaurantDetailModel {
  late RestaurantInfoModel restaurantInfo;
  late List<MenuInfoModel> menuInfoList;
  late List<WaitingTimeModel> waitingTimeList;

  RestaurantDetailModel({
    required this.restaurantInfo,
    required this.menuInfoList,
    required this.waitingTimeList,
  });
}
