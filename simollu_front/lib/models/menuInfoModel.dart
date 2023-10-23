// "menuSeq": 1395,
// "menuName": "정가브리(180g)",
// "menuImage": "https://simollu.s3.ap-northeast-2.amazonaws.com/compressed/yeoksam-dong_3/28e25e7e-c04a-48d7-8360-679dd59bd432.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230516T022800Z&X-Amz-SignedHeaders=host&X-Amz-Expires=7200&X-Amz-Credential=AKIAYHNWF3O62LVPH6F7%2F20230516%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=e004a779b20e0d641c454b4f2ef7a0566c21474eb24f85fcfe154c5ec2506577",
// "menuPrice": "17,000원"

class MenuInfoModel {

  late int menuSeq;
  late String menuName;
  late String menuImage;
  late String menuPrice;

  MenuInfoModel.fromJSON(Map<String, dynamic> json)
  : menuSeq = json['menuSeq'],
    menuName = json['menuName'] ?? '',
    menuImage = json['menuImage'] ?? '',
    menuPrice = json['menuPrice'] ?? '';

}