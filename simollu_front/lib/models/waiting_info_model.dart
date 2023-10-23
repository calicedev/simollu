/*
timeZone": "19:00-20:00",
"expectedWaitingTime": 41
*/

class WaitingInfoModel {
  final String timeZone;
  final int expectedWaitingTime;

  WaitingInfoModel({
    required this.timeZone,
    required this.expectedWaitingTime,
  });

  WaitingInfoModel.fromJSON(Map<String, dynamic> json)
      : timeZone = json['timeZone'],
        expectedWaitingTime = json['expectedWaitingTime'] ?? 0;
}
