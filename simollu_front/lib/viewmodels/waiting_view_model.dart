import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simollu_front/models/delay_info_model.dart';
import 'package:simollu_front/services/waiting_api.dart';

import '../utils/token.dart';
import 'package:simollu_front/models/waiting_record_model.dart';
import 'package:http/http.dart' as http;

class WaitingViewModel extends GetxController {
  RxInt waitingSeq = (-1).obs;
  RxInt waitingNo = (-1).obs;
  RxInt waitingTime = (-1).obs;
  RxString restaurantName = "".obs;
  RxInt restaurantSeq = (-1).obs;
  RxInt waitingPersonCnt = (-1).obs;
  RxString waitingStatusRegistDate = "".obs;
  RxInt waitingStatusContent = (-1).obs;
  RxInt waitingCurRank = (-1).obs;
  Rx<DelayInfoModel?> delayInfo = Rx<DelayInfoModel?>(null);

  static Uri createUrl(String apiUrl) {
    Uri url = Uri.https('simollu.com', '/api$apiUrl');
    return url;
  }

  Future<void> getDelayInfo() async {
    delayInfo.value = await WaitingApi().getDelayInfo(restaurantSeq.value);
    print(delayInfo.value!.waitingTime.toString() + "adsfsdfsdf");
  }

  Future<bool> delayOrder() async {
    WaitingRecordModel? res = await WaitingApi().delayOrder(
        waitingSeq.value, restaurantSeq.value, restaurantName.value);
    if (res != null) {
      waitingSeq.value = res.waitingSeq;
      waitingNo.value = res.waitingNo;
      waitingTime.value = res.waitingTime;
      restaurantName.value = res.restaurantName;
      restaurantSeq.value = res.restaurantSeq;
      waitingPersonCnt.value = res.waitingPersonCnt;
      waitingStatusRegistDate.value = res.waitingStatusRegistDate;
      waitingStatusContent.value = res.waitingStatusContent;
      waitingCurRank.value = res.waitingCurRank;
      return true;
    }
    return false;
  }

  Future<void> cancelWaiting() async {
    bool res = await WaitingApi().cancelWaiting(waitingSeq.value);

    if (res) {
      waitingSeq.value = -1;
      waitingNo.value = -1;
      waitingTime.value = -1;
      restaurantName.value = "";
      restaurantSeq.value = -1;
      waitingPersonCnt.value = -1;
      waitingStatusRegistDate.value = "";
      waitingStatusContent.value = -1;

      waitingCurRank.value = -1;
    }
  }

  Future<bool> postWaiting(
      int restaurantSeq, int waitingPersonCnt, String restaurantName) async {
    print(waitingPersonCnt.toString() + "웨이팅 사람 수");
    WaitingRecordModel? res = await WaitingApi()
        .postWaiting(restaurantSeq, waitingPersonCnt, restaurantName);
    if (res == null) {
      return false;
    }
    waitingSeq.value = res.waitingSeq;
    // waitingNo.value = res.waitingNo;
    // waitingTime.value = res.waitingTime;
    // this.restaurantName.value = res.restaurantName;
    await getWaitingInfo();
    return true;
  }

  Future<void> getWaitingInfo() async {
    WaitingRecordModel? res =
        await WaitingApi().getWaitingInfo(waitingSeq.value);
    if (res != null) {
      waitingSeq.value = res.waitingSeq;
      restaurantSeq.value = res.restaurantSeq;
      waitingPersonCnt.value = res.waitingPersonCnt;
      waitingNo.value = res.waitingNo;
      waitingTime.value = res.waitingTime;
      restaurantName.value = res.restaurantName;
      waitingStatusRegistDate.value = res.waitingStatusRegistDate;
      waitingStatusContent.value = res.waitingStatusContent;

      waitingCurRank.value = res.waitingCurRank;
    } else {
      waitingSeq.value = -1;
      waitingNo.value = -1;
      waitingTime.value = -1;
      restaurantName.value = "";
      restaurantSeq.value = -1;
      waitingPersonCnt.value = -1;
      waitingStatusRegistDate.value = "";
      waitingStatusContent.value = -1;

      waitingCurRank.value = -1;
    }
  }

  // 웨이팅 내역 조회(완료)
  static Future<List<WaitingRecordModel>> fetchWaitingRecord(
      int waitingStatusContent) async {
    List<WaitingRecordModel> result = [];
    String token = await getToken();
    var url = createUrl('/waiting/user/status/$waitingStatusContent');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      },
    );

    if (response.statusCode == 200) {
      final decodedList = jsonDecode(utf8.decode(response.bodyBytes));
      result = (decodedList as List)
          .map((item) => WaitingRecordModel.fromJson(item))
          .toList();
    } else {
      throw Error();
    }
    print(result);
    return result;
  }
}
