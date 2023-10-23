class ForkModel {
  final int userForkDiff;
  final int userForkAmount;
  final String userForkType;
  final String userForkContent;
  final String userForkRegisterDate;

  ForkModel({
    required this.userForkDiff,
    required this.userForkAmount,
    required this.userForkType,
    required this.userForkContent,
    required this.userForkRegisterDate,
  });

  factory ForkModel.fromJson(Map<String, dynamic> json) {
    return ForkModel(
      userForkDiff: json['userForkDiff'] as int,
      userForkAmount: json['userForkAmount'] as int,
      userForkType: json['userForkType'] as String,
      userForkContent: json['userForkContent'] as String,
      userForkRegisterDate: json['userForkRegisterDate'] as String,
    );
  }
}