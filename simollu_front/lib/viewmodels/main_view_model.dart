import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simollu_front/models/main_info_model.dart';
import 'package:simollu_front/models/restaurant_model.dart';
import 'package:simollu_front/services/main_api.dart';

enum SortBy {
  NearBy,
  HighRaiting,
  LessWaiting,
}

enum Category {
  Korean,
  Western,
  Chinese,
  Japanese,
  FastFood,
  Cafe,
  Bakery,
}

class MainViewModel extends GetxController {
  Rx<SortBy> sortBy = SortBy.NearBy.obs;
  Rx<Category> category = Category.Korean.obs;
  RxList<RestaurantModel> recentlyHotList = <RestaurantModel>[].obs;
  RxList<RestaurantModel> tryHereList = <RestaurantModel>[].obs;
  Rx<MainInfoModel> mainInfo = MainInfoModel(
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
  ).obs;
  // 메인화면 식당 정보 리스트 상태 등록

  void changeSortBy(SortBy newSortBy) {
    sortBy.value = newSortBy;
    switch (newSortBy) {
      case SortBy.NearBy:
        tryHereList.value = mainInfo.value.restaurantNearByList;
        break;
      case SortBy.HighRaiting:
        tryHereList.value = mainInfo.value.restaurantHighRatingList;
        break;
      case SortBy.LessWaiting:
        tryHereList.value = mainInfo.value.restaurantLessWaitingList;
        break;
      default:
        break;
    }
  }

  void changeCategroy(Category newCategory) {
    category.value = newCategory;
    switch (newCategory) {
      case Category.Korean:
        recentlyHotList.value = mainInfo.value.koreanFoodTopList;
        break;
      case Category.Western:
        recentlyHotList.value = mainInfo.value.westernFoodTopList;
        break;
      case Category.Chinese:
        recentlyHotList.value = mainInfo.value.chineseTopList;
        break;
      case Category.Japanese:
        recentlyHotList.value = mainInfo.value.japaneseTopList;
        break;
      case Category.FastFood:
        recentlyHotList.value = mainInfo.value.fastFoodTopList;
        break;
      case Category.Cafe:
        recentlyHotList.value = mainInfo.value.cafeTopList;
        break;
      case Category.Bakery:
        recentlyHotList.value = mainInfo.value.bakeryTopList;
        break;
      default:
        break;
    }
  }

  void getMainInfo(LatLng currentPosition) async {
    mainInfo.value = await MainApi().getRestaurantList(currentPosition);

    recentlyHotList.value = mainInfo.value.koreanFoodTopList;
    tryHereList.value = mainInfo.value.restaurantNearByList;
  }
}
