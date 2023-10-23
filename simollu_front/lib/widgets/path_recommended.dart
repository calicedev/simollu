import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';
import 'package:simollu_front/viewmodels/map_view_model.dart';
import 'package:simollu_front/widgets/route_widget.dart';

class PathRecommended extends StatelessWidget {
  final Function event;
  const PathRecommended({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    MapViewModel mapViewModel = Get.find();
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Obx(
        () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: mapViewModel.pathMap.entries.map((entry) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    event(entry.key);
                  },
                  child: RouteWidget(routes: entry.value, wayPoint: entry.key),
                ),
              );
            }).toList()),
      ),
    );
  }
}
