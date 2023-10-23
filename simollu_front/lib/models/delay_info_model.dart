class DelayInfoModel {
  final int waitingTeam;
  final int waitingTime;

  DelayInfoModel({
    required this.waitingTeam,
    required this.waitingTime,
  });

  DelayInfoModel.fromJSON(Map<String, dynamic> json)
      : waitingTeam = json['waitingTeam'] ?? 0,
        waitingTime = json['waitingTime'] ?? 0;
}
