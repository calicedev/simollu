// "waitingSeq": 1,
// "userSeq": "p123456789dsefd01",
// "restaurantSeq": 7,
// "waitingPersonCnt": 4,
// "waitingNo": 1,
// "restaurantName": "도원",
// "waitingStatusRegistDate": "2023-05-10T22:21:55.5912175",
// "waitingStatusContent": 3


class WaitingUserModel {
  late int waitingSeq;
  late String userSeq;
  late int restaurantSeq;
  late int waitingPersonCnt;
  late int waitingNo;
  late String restaurantName;
  late String waitingStatusRegistDate;
  late int waitingStatusContent;

  WaitingUserModel.fromJSON(Map<String, dynamic> json)
      : waitingSeq = json['waitingSeq'],
        userSeq = json['userSeq'] ?? '',
        restaurantSeq = json['restaurantSeq'],
        waitingPersonCnt = json['waitingPersonCnt'],
        waitingNo = json['waitingNo'],
        restaurantName = json['restaurantName'] ?? '',
        waitingStatusRegistDate = json['waitingStatusRegistDate'] ?? '',
        waitingStatusContent = json['waitingStatusContent'];
}