
class PreferenceModel {
  String? userSeq;
  List<String>? userPrefernceList;

  PreferenceModel({this.userPrefernceList});

  PreferenceModel.fromJson(Map<String, dynamic> json) {
    userPrefernceList = json['userPrefernceList'].map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userPrefernceList'] = userPrefernceList;
    return data;
  }
}