class WriteableModel {
  int? writeableSeq;
  String? userSeq;
  int? restaurantSeq;
  String? waitingCompleteDate;
  String? restaurantName;
  String? restaurantImg;

  WriteableModel(
      {
        this.writeableSeq,
        this.userSeq,
        this.restaurantSeq,
        this.waitingCompleteDate,
        this.restaurantName,
        this.restaurantImg});

  WriteableModel.fromJson(Map<String, dynamic> json)
    : writeableSeq = json['writeableSeq'],
      userSeq = json['userSeq'],
      restaurantSeq = json['restaurantSeq'],
      waitingCompleteDate = json['waitingCompleteDate'],
      restaurantName = json['restaurantName'],
      restaurantImg = json['restaurantImg'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['writeableSeq'] = writeableSeq;
    data['userSeq'] = userSeq;
    data['restaurantSeq'] = restaurantSeq;
    data['waitingCompleteDate'] = waitingCompleteDate;
    data['restaurantName'] = restaurantName;
    data['restaurantImg'] = restaurantImg;
    return data;
  }
}
