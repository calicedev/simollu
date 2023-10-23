class WaitingRecordModel {
  final int waitingSeq;
  final String userSeq;
  final int restaurantSeq;
  final int waitingPersonCnt;
  final int waitingNo;
  final int waitingTime;
  final int waitingCurRank;
  final String restaurantName;
  final String waitingStatusRegistDate;
  final int waitingStatusContent;

  WaitingRecordModel({
    required this.waitingSeq,
    required this.userSeq,
    required this.restaurantSeq,
    required this.waitingPersonCnt,
    required this.waitingNo,
    required this.waitingTime,
    required this.waitingCurRank,
    required this.restaurantName,
    required this.waitingStatusRegistDate,
    required this.waitingStatusContent,
  });

  WaitingRecordModel.fromJson(Map<String, dynamic> json)
      : waitingSeq = json['waitingSeq'] ?? 0,
        userSeq = json['userSeq'] ?? "",
        restaurantSeq = json['restaurantSeq'] ?? 0,
        waitingPersonCnt = json['waitingPersonCnt'] ?? 0,
        waitingNo = json['waitingNo'] ?? 0,
        waitingTime = json['waitingTime'] ?? 0,
        waitingCurRank = json['waitingCurRank'] ?? 0,
        restaurantName = json['restaurantName'] ?? "",
        waitingStatusRegistDate = json['waitingStatusRegistDate'] ?? "",
        waitingStatusContent = json['waitingStatusContent'] ?? -1;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['waitingSeq'] = waitingSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['waitingPersonCnt'] = waitingPersonCnt;
    data['waitingNo'] = waitingNo;
    data['restaurantName'] = restaurantName;
    data['waitingStatusRegistDate'] = waitingStatusRegistDate;
    data['waitingStatusContent'] = waitingStatusContent;
    return data;
  }
}
