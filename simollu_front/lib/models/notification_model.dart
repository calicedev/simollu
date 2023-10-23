
class NotificationModel {
  int? alertSeq;
  String? userSeq;
  String? alertTitle;
  String? alertContent;
  String? alertRegistDate;
  bool? alertIsRead;

  NotificationModel({
    this.alertSeq,
    this.userSeq,
    this.alertTitle,
    this.alertContent,
    this.alertRegistDate,
    this.alertIsRead
  });

  NotificationModel.fromJson(Map<String, dynamic> json)
      : alertSeq = json['alertSeq'],
        userSeq = json['userSeq'],
        alertTitle = json['alertTitle'],
        alertContent = json['alertContent'],
        alertRegistDate = json['alertRegistDate'],
        alertIsRead = json['alertIsRead'];


  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['alertSeq'] = alertSeq;
    data['userSeq'] = userSeq;
    data['alertTitle'] = alertTitle;
    data['alertContent'] = alertContent;
    data['alertRegistDate'] = alertRegistDate;
    data['alertIsRead'] = alertIsRead;
    return data;
  }


}
