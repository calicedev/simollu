import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum MarkerType {
  start,
  destination,
  waypoint,
  myLocation,
}

class CustomMarker {
  final String markerId;
  final LatLng latLng;
  final MarkerType type;

  const CustomMarker({
    required this.markerId,
    required this.latLng,
    required this.type,
  });

  Future<Marker> getMarker() async {
    late BitmapDescriptor marker;
    switch (type) {
      case MarkerType.start:
        marker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/icons/start.png",
        );
        break;
      case MarkerType.destination:
        marker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/icons/destination.png",
        );
        break;
      case MarkerType.waypoint:
        marker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/icons/waypoint.png",
        );
        break;
      case MarkerType.myLocation:
        marker = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(),
          "assets/icons/mylocation.png",
        );
        break;
    }

    return Marker(
      markerId: MarkerId(markerId),
      position: latLng,
      icon: marker,
      zIndex: type == MarkerType.myLocation ? 1 : 0,
    );
  }
}
