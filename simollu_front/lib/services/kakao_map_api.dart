import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:simollu_front/models/address_model.dart';

import 'package:simollu_front/models/place.dart';

class KakaoMapAPI {
  final String baseUrl = 'https://dapi.kakao.com/v2/local';

  Future<String> getCurrentLocationAddress(LatLng location) async {
    String apiUrl = baseUrl +
        "/geo/coord2address.json?x=${location.longitude}&y=${location.latitude}&input_coord=WGS84";
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': dotenv.env['kakaoMapApiKey']!,
    });
    if (response.statusCode == 200) {
      AddressModel address = AddressModel.fromJSON(
          json.decode(response.body)['documents'][0]['address']);
      return (address.region3DepthName);
    }
    return "내 위치 찾기";
  }

  Future<List<Place>> getPlaces(LatLng dest, String keyword) async {
    String apiUrl = baseUrl +
        "/search/keyword.JSON?query=${keyword}&x=${dest.longitude}&y=${dest.latitude}&radius=500";
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': dotenv.env['kakaoMapApiKey']!,
    });
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      List<Place> ret = [];
      List<dynamic> placeList = json.decode(response.body)['documents'];
      for (dynamic places in placeList) {
        ret.add(Place.fromJSON(places));
      }
      return ret;
    } else {
      // 요청 실패 처리
      return [];
    }
  }

  /*
  */
}
