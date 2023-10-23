class RestaurantModel {
  final int restaurantSeq;
  final String restaurantName;
  final int restaurantRating;
  final int restaurantWaitingTime;
  final String restaurantImage;
  final String restaurantAddress;
  final double distance;
  final String restaurantCategory;
  final String restaurantX;
  final String restaurantY;
  // 좋아요 필요할듯 - 관심식당 페이지

  RestaurantModel({
    required this.restaurantSeq,
    required this.restaurantName,
    required this.restaurantRating,
    required this.restaurantWaitingTime,
    required this.restaurantImage,
    required this.restaurantAddress,
    required this.distance,
    required this.restaurantCategory,
    required this.restaurantX,
    required this.restaurantY,
  });

  RestaurantModel.fromJSON(Map<String, dynamic> json)
      : restaurantSeq = json['restaurantSeq'] ?? '',
        restaurantName = json['restaurantName'] ?? '',
        restaurantRating = json['restaurantRating'] ?? 0,
        restaurantWaitingTime = json['restaurantWaitingTime'] ?? 0,
        restaurantImage = json['restaurantImage'] ?? '',
        restaurantAddress = json['restaurantAddress'] ?? '',
        distance = json['distance'] ?? 0,
        restaurantCategory = json['restaurantCategory'] ?? '',
        restaurantX = json['restaurantX'] ?? '0',
        restaurantY = json['restaurantY'] ?? '0';
}
