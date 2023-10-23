import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/root.dart';

import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/viewmodels/preference_view_model.dart';
import 'package:simollu_front/viewmodels/waiting_view_model.dart';
import 'package:simollu_front/widgets/custom_marker.dart';
import 'package:simollu_front/widgets/custom_tabBar.dart';
import 'package:simollu_front/widgets/path_recommended.dart';
import 'package:simollu_front/widgets/path_search_result.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 지도 카메라 컨트롤
  final Completer<GoogleMapController> _controller = Completer();

  late StreamSubscription<Position> positionStreamSubscription;

  WaitingViewModel waitingViewModel = Get.find();
  PreferenceViewModel preferenceViewModel = Get.find();

  bool _locationPermission = false;

  MapViewModel mapViewModel = Get.find();

  @override
  void initState() {
    super.initState();

    void listening() async {
      await _getCurrentLocation();

      mapViewModel.start.value = LatLng(
          mapViewModel.currentPosition.value!.latitude,
          mapViewModel.currentPosition.value!.longitude);
      if (_locationPermission) {
        await mapViewModel.addMarker();
        // 관심 검색하는 부분

        for (String place in preferenceViewModel.places) {
          await mapViewModel.getPlaces(place);
        }
        if (mapViewModel.placeList.isNotEmpty) {
          for (Place place in mapViewModel.placeList) {
            await mapViewModel.findPaths(
                place, place.lng.toString() + "," + place.lat.toString());
          }
        } else {
          await mapViewModel.findPaths(
              Place(
                address: "",
                lat: 0,
                lng: 0,
                id: "",
                name: mapViewModel.restaurantName.value,
              ),
              "");
        }
      }
      _startListening();
    }

    listening();
  }

  @override
  void dispose() {
    positionStreamSubscription.cancel();
    super.dispose();
  }

  void _startListening() {
    final locationSettings =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    positionStreamSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      _onLocationChanged(position);
    });
  }

  Future<void> _getCurrentLocation() async {
    if (mapViewModel.locationPermission.value == LocationPermission.denied ||
        mapViewModel.locationPermission.value ==
            LocationPermission.deniedForever) {
      // return Future.error('위치 권한 거부');
      await mapViewModel.getLocationPermission();
      if (mapViewModel.locationPermission.value == LocationPermission.denied ||
          mapViewModel.locationPermission.value ==
              LocationPermission.deniedForever) {
        return;
      }
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      // mapViewModel.currentPosition.value = position;
      Marker myLocation = await CustomMarker(
              markerId: "myLocation",
              latLng: LatLng(mapViewModel.currentPosition.value!.latitude,
                  mapViewModel.currentPosition.value!.longitude),
              type: MarkerType.myLocation)
          .getMarker();
      mapViewModel.markers.add(myLocation);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 19,
      )));
    }).catchError((e) {
      print(e);
    });

    setState(() {
      _locationPermission = true;
    });
  }

  void _onLocationChanged(Position position) async {
    // mapViewModel.currentPosition.value = position;
    Marker myLocation = await CustomMarker(
            markerId: "myLocation",
            latLng: LatLng(mapViewModel.currentPosition.value!.latitude,
                mapViewModel.currentPosition.value!.longitude),
            type: MarkerType.myLocation)
        .getMarker();
    mapViewModel.markers.remove(mapViewModel.markers
        .firstWhere((marker) => marker.markerId == MarkerId('myLocation')));
    mapViewModel.markers.add(myLocation);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 19,
    )));
  }

  void onClickPath(Place key) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
            (mapViewModel.start.value.latitude +
                    mapViewModel.destination.value.latitude) /
                2,
            (mapViewModel.start.value.longitude +
                    mapViewModel.destination.value.longitude) /
                2),
        zoom: 16.0,
      ),
    ));

    Marker? waypoint = mapViewModel.markers.firstWhere(
      (marker) => marker.markerId == MarkerId('waypoint'),
      orElse: () => Marker(
        markerId: MarkerId('default'),
      ),
    );
    if (waypoint.markerId != MarkerId('default')) {
      mapViewModel.markers.remove(waypoint);
    }
    waypoint = await CustomMarker(
            markerId: "waypoint",
            latLng: LatLng(key.lat, key.lng),
            type: MarkerType.waypoint)
        .getMarker();
    mapViewModel.markers.add(waypoint);

    mapViewModel.polylineList.value = mapViewModel.polylineMap[key]!;
  }

  void search(String keyword) async {
    await mapViewModel.searchPlaces(keyword);

    mapViewModel.searchPathMap.clear();
    for (Place place in mapViewModel.searchPlaceList) {
      await mapViewModel.searchPaths(
          place, place.lng.toString() + "," + place.lat.toString());
    }

    Marker waypoint = mapViewModel.markers.firstWhere(
      (marker) => marker.markerId == MarkerId('waypoint'),
      orElse: () => Marker(markerId: MarkerId('default')),
    );

    if (waypoint.markerId != MarkerId('default')) {
      mapViewModel.markers.remove(waypoint);
    }
    mapViewModel.polylineList.value = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                if (waitingViewModel.waitingSeq.value == -1) {
                  RootController.to.onWillPop();
                }
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '대기번호',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text: waitingViewModel.waitingNo.value.toString(),
                        style: TextStyle(
                          color: Color(0xFFFFD200),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                width: 24,
              ),
              Obx(
                () => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '예상대기시간',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 8,
                        ),
                      ),
                      TextSpan(
                        text: "${waitingViewModel.waitingTime.value}분",
                        style: TextStyle(
                          color: Color(0xFFFFD200),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Obx(() {
                  Set<Marker> markers = Set.from(mapViewModel.markers);
                  return GoogleMap(
                    polylines: Set<Polyline>.of(mapViewModel.polylineList),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: mapViewModel.center.value,
                      zoom: 19.0,
                    ),
                    zoomControlsEnabled: false,
                    markers: mapViewModel.markers,
                    mapType: MapType.terrain,
                  );
                }),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xFFFFD200),
                    splashColor: Color(0xFFFFD200),
                    onPressed: _locationPermission
                        ? () async {
                            final GoogleMapController controller =
                                await _controller.future;
                            controller
                                .animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                    mapViewModel
                                        .currentPosition.value!.latitude,
                                    mapViewModel
                                        .currentPosition.value!.longitude),
                                zoom: 19.0,
                              ),
                            ));
                          }
                        : null,
                    child: Icon(Icons.location_searching),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomTabBar(
              length: 2,
              tabs: ['추천 경로', '검색'],
              tabViews: [
                PathRecommended(
                  event: onClickPath,
                ),
                PathSearchResult(
                  clickEvent: onClickPath,
                  search: search,
                ),
              ],
            ),
          ),
          // SingleChildScrollView(
          // ),
        ],
      ),
    );
  }
}
