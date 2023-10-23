class SearchModel {
  // 검색 결과 api
  // 현재위치 : 위도
  // 현재위치 : 경도
  // late String keyword; // 검색어
  // double lat = 37.5013068; // 현재위치 : 위도
  // double long = 127.0396597; // 현재위치 : 경도

  late int restaurantSeq;
  late String restaurantName;
  late int restaurantRating;
  late String restaurantImg;
  late String restaurantX;
  late String restaurantY;
  late int restaurantWaitingTime;
  late int restaurantWaitingTeam;
  late double distance;
  // "restaurantSeq": 7,
  // "restaurantName": "코애식당",
  // "restaurantRating": 0,
  // "restaurantImg": "https://simollu.s3.ap-northeast-2.amazonaws.com/compressed/gasan-dong_1/0a13bf16-5ad5-4078-8ef2-97eebc9be2a3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230509T072941Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Credential=AKIAYHNWF3O62LVPH6F7%2F20230509%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=770daa6074915a36e095652f93429c32882038209f7765c12950aaf7f4f09c62",
  // "restaurantX": "126.8777911",
  // "restaurantY": "37.47838349",
  // "distanceTime": 15.77473767019752

  SearchModel(
      {required this.restaurantSeq,
      required this.restaurantName,
      required this.restaurantRating,
      required this.restaurantImg,
      required this.restaurantX,
      required this.restaurantY,
      required this.restaurantWaitingTime,
      required this.restaurantWaitingTeam,
      required this.distance});

  SearchModel.fromMap(Map<String, dynamic>? map) {
    restaurantSeq = map?['restaurantSeq'] ?? '';
    restaurantName = map?['restaurantName'] ?? '';
    restaurantRating = map?['restaurantRating'] ?? '';
    restaurantImg = map?['restaurantImg'] ?? '';
    restaurantX = map?['restaurantX'] ?? 0;
    restaurantY = map?['restaurantY'] ?? 0;
    distance = map?['distance'] ?? 0;
  }

  SearchModel.fromJSON(Map<String, dynamic> json)
      : restaurantSeq = json['restaurantSeq'],
        restaurantName = json['restaurantName'] ?? '',
        restaurantRating = json['restaurantRating'],
        restaurantImg = json['restaurantImg'] ?? '',
        restaurantX = json['restaurantX'] ?? '0',
        restaurantY = json['restaurantY'] ?? '0',
        restaurantWaitingTime = json['restaurantWaitingTime'] ?? 0,
        restaurantWaitingTeam = json['restaurantWaitingTeam'] ?? 0,
        distance = json['distance'];
}
