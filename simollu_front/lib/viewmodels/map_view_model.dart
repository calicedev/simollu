import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/services/kakao_map_api.dart';
import 'package:simollu_front/services/t_map_api.dart';
import 'package:simollu_front/widgets/custom_marker.dart';

class MapViewModel extends GetxController {
  int polylineId = 0;
  RxString restaurantName = "".obs;
  RxString dong = "내 위치 찾기".obs;
  Rx<LocationPermission> locationPermission = LocationPermission.denied.obs;
  RxList<Place> placeList = <Place>[].obs;
  RxList<Place> searchPlaceList = <Place>[].obs;
  RxList<Polyline> polylineList = <Polyline>[].obs;
  RxMap<Place, List<Polyline>> polylineMap = <Place, List<Polyline>>{}.obs;

  // Rx<Position> currentPosition = Rx<Position?>(null);
  Rx<LatLng> currentPosition = LatLng(37.5013068, 127.0396597).obs;

  Rx<LatLng> start = LatLng(37.5013068, 127.0396597).obs;
  Rx<LatLng> destination = LatLng(37.5047984, 127.0434318).obs;
  Rx<LatLng> center = LatLng(37.5013068, 127.0396597).obs;
  RxMap<String, List<String>> routes = {
    "default": <String>[],
  }.obs;

  RxMap<Place, List<PathSegment>> pathMap = <Place, List<PathSegment>>{}.obs;

  RxMap<Place, List<PathSegment>> searchPathMap =
      <Place, List<PathSegment>>{}.obs;

  RxSet<Marker> markers = <Marker>{}.obs;

  Future<void> getDong() async {
    String newDong = await KakaoMapAPI().getCurrentLocationAddress(LatLng(
        currentPosition.value!.latitude, currentPosition.value!.longitude));

    dong.value = newDong;
  }

  void resetMapData() {
    markers.clear();
    pathMap.clear();
    searchPathMap.clear();
    polylineList.clear();
    polylineMap.clear();
    placeList.clear();
    searchPlaceList.clear();
  }

  Future<void> getLocationPermission() async {
    locationPermission.value = await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // currentPosition.value = position;
    });
    if (locationPermission.value != LocationPermission.denied &&
        locationPermission.value != LocationPermission.deniedForever) {
      getDong();
    }
  }

  Future<void> addMarker() async {
    Marker destinationMarker = await CustomMarker(
            markerId: "destination",
            latLng: destination.value,
            type: MarkerType.destination)
        .getMarker();

    markers.add(destinationMarker);
    // final Position? position = currentPosition.value;

    Marker startMarker = await CustomMarker(
            markerId: "start", latLng: start.value, type: MarkerType.start)
        .getMarker();

    markers.add(startMarker);
  }

  Future<void> findPaths(Place place, String passList) async {
    List<PathSegment> pathList =
        await TMapAPI().findPaths(start.value, destination.value, passList);

    pathMap[place] = pathList;

    List<Polyline> polylineList = [];
    for (PathSegment path in pathList) {
      for (int i = 0; i < path.coordinates.length - 1; i++) {
        polylineList.add(Polyline(
          polylineId: PolylineId(polylineId.toString()),
          points: [
            LatLng(path.coordinates[i][1], path.coordinates[i][0]),
            LatLng(path.coordinates[i + 1][1], path.coordinates[i + 1][0]),
          ],
          color: Colors.red,
          width: 5,
        ));
        polylineId++;
      }
    }
    polylineMap[place] = polylineList;
  }

  Future<void> searchPaths(Place place, String passList) async {
    List<PathSegment> pathList =
        await TMapAPI().findPaths(start.value, destination.value, passList);

    searchPathMap[place] = pathList;

    List<Polyline> polylineList = [];
    for (PathSegment path in pathList) {
      for (int i = 0; i < path.coordinates.length - 1; i++) {
        polylineList.add(Polyline(
          polylineId: PolylineId(polylineId.toString()),
          points: [
            LatLng(path.coordinates[i][1], path.coordinates[i][0]),
            LatLng(path.coordinates[i + 1][1], path.coordinates[i + 1][0]),
          ],
          color: Colors.red,
          width: 5,
        ));
        polylineId++;
      }
    }
    polylineMap[place] = polylineList;
  }

  Future<void> getPlaces(String keyword) async {
    placeList.addAll(await KakaoMapAPI().getPlaces(destination.value, keyword));
  }

  Future<void> searchPlaces(String keyword) async {
    searchPlaceList.value =
        await KakaoMapAPI().getPlaces(destination.value, keyword);
  }
}
