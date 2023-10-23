// "timeZone": "17:00-18:00",
// "expectedWaitingTime": 6
class WaitingTimeModel {
  late String timeZone;
  late int expectedWaitingTime;

  WaitingTimeModel.fromJSON(Map<String, dynamic> json)
      : timeZone = json['timeZone'] ?? '',
        expectedWaitingTime = json['expectedWaitingTime'] ?? 0;
}
