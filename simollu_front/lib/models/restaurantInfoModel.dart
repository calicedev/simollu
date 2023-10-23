// "restaurantSeq": 10,
// "restaurantName": "신동궁감자탕 역삼직영점",
// "restaurantCategory": "감자탕",
// "restaurantBusinessHours": "매일 00:00 - 24:00,\n",
// "restaurantPhoneNumber": "02-555-3782",
// "restaurantAddress": "서울 강남구 테헤란로10길 21 1층 신동궁감자탕뼈숯불구이",
// "restaurantImg": "https://simollu.s3.ap-northeast-2.amazonaws.com/compressed/yeoksam-dong_1/75ffeef4-70c1-4c13-8369-1f05b2f2b9fe.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230512T053645Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7199&X-Amz-Credential=AKIAYHNWF3O62LVPH6F7%2F20230512%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=1c6626444244e27d8224d14cce30ffcdc6a7c9e35e5bff3fc13c924f7695a7e8",
// "restaurantRating": 0

class RestaurantInfoModel {
  late int restaurantSeq;
  late String restaurantName;
  late String restaurantCategory;
  late String restaurantBusinessHours;
  late String restaurantPhoneNumber;
  late String restaurantAddress;
  late String restaurantImg;
  late int restaurantRating;
  late bool restaurantLike;

  RestaurantInfoModel({
    required this.restaurantSeq,
    required this.restaurantName,
    required this.restaurantCategory,
    required this.restaurantBusinessHours,
    required this.restaurantPhoneNumber,
    required this.restaurantAddress,
    required this.restaurantImg,
    required this.restaurantRating,
    required this.restaurantLike,
  });

  RestaurantInfoModel.fromJSON(Map<String, dynamic> json)
      : restaurantSeq = json['restaurantSeq'],
        restaurantName = json['restaurantName'] ?? '',
        restaurantCategory = json['restaurantCategory'] ?? '',
        restaurantBusinessHours = json['restaurantBusinessHours'] ?? '',
        restaurantPhoneNumber = json['restaurantPhoneNumber'] ?? '',
        restaurantAddress = json['restaurantAddress'] ?? '',
        restaurantImg = json['restaurantImg'],
        restaurantRating = json['restaurantRating'],
        restaurantLike = json['restaurantLike'];
}
