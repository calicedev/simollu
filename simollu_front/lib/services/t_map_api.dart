import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:simollu_front/models/path_segment.dart';

class TMapAPI {
  final String apiUrl =
      'https://apis.openapi.sk.com/tmap/routes/pedestrian?version=1';

  Future<List<PathSegment>> findPaths(
      LatLng start, LatLng end, String passList) async {
    Map<String, dynamic> requestData = {
      'startX': start.longitude.toString(),
      'startY': start.latitude.toString(),
      'speed': (5).toString(),
      'endX': end.longitude.toString(),
      'endY': end.latitude.toString(),
      'startName': Uri.encodeComponent('현재 위치'),
      'endName': Uri.encodeComponent('도착 위치'),
    };
    if (passList.length != 0) {
      requestData['passList'] = passList;
    }
    var response = await http
        .post(Uri.parse(apiUrl), body: json.encode(requestData), headers: {
      'appKey': dotenv.env['tMapApiKey']!,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      // 응답 데이터 처리
      List<PathSegment> ret = [];
      List<dynamic> pathList = json.decode(response.body)['features'];
      for (dynamic paths in pathList) {
        if (paths['geometry']['type'] == 'Point') {
          if (paths['properties']['pointType'] == 'PP1') {
            List<String> coordinate = passList.split(',');
            ret.add(PathSegment.fromPointJSON(
              paths,
              [double.parse(coordinate[1]), double.parse(coordinate[0])],
            ));
          }
          continue;
        }
        ret.add(PathSegment.fromJSON(paths));
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
