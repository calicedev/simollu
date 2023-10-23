// "reviewSeq": 28,
// "userSeq": "9030f201-c3a3-4ff9-a411-2359392b65e0",
// "restaurantSeq": 124,
// "reviewRating": true,
// "reviewContent": "good",
// "reviewRegistDate": "2023-05-16T10:54:12.763435",
// "userNickName": "김수형",
// "userImg": "profile/KakaoTalk_20230410_100241747.jpg",

class RestaurantReviewModel {
  late int reviewSeq;
  late String userSeq;
  late int restaurantSeq;
  late bool reviewRating;
  late String reviewContent;
  late String reviewRegistDate;
  late String userImg;
  late String userNickname;

  RestaurantReviewModel({
    required this.reviewSeq,
    required this.userSeq,
    required this.restaurantSeq,
    required this.reviewRating,
    required this.reviewContent,
    required this.reviewRegistDate,
    required this.userImg,
    required this.userNickname,
  });

  RestaurantReviewModel.fromJson(Map<String, dynamic> json) {
    reviewSeq = json['reviewSeq'];
    userSeq = json['userSeq'];
    restaurantSeq = json['restaurantSeq'];
    reviewRating = json['reviewRating'];
    reviewContent = json['reviewContent'];
    reviewRegistDate = json['reviewRegistDate'];
    userImg = json['userImg'];
    userNickname = json['userNickName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewSeq'] = reviewSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['reviewRating'] = reviewRating;
    data['reviewContent'] = reviewContent;
    data['reviewRegistDate'] = reviewRegistDate;
    return data;
  }
}
