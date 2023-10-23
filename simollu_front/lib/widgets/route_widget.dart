import 'package:flutter/material.dart';
import 'package:simollu_front/models/path_segment.dart';
import 'package:simollu_front/models/place.dart';

class RouteWidget extends StatelessWidget {
  final List<PathSegment> routes;
  final Place wayPoint;
  const RouteWidget({super.key, required this.routes, required this.wayPoint});

  @override
  Widget build(BuildContext context) {
    int beforeTime = 0;
    int afterTime = 0;
    bool isBefore = true;
    for (PathSegment route in routes) {
      if (isBefore) {
        beforeTime += route.time;
      } else {
        afterTime += route.time;
      }
      if (route.description.compareTo(("경유지")) == 0) {
        isBefore = false;
      }
    }
    return Container(
      width: 360,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey.withOpacity(0.6),
            offset: Offset(0, 3),
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFAAAAAA),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              wayPoint.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: "도보 ${(beforeTime / 60).round().toString()}분",
                  ),
                  WidgetSpan(
                      child: Icon(
                    Icons.arrow_forward,
                  )),
                  TextSpan(
                    children: afterTime == 0
                        ? null
                        : [
                            TextSpan(
                              text: wayPoint.name,
                            ),
                            WidgetSpan(
                                child: Icon(
                              Icons.arrow_forward,
                            )),
                            TextSpan(
                              text:
                                  "도보 ${(afterTime / 60).round().toString()}분",
                            ),
                            WidgetSpan(
                                child: Icon(
                              Icons.arrow_forward,
                            )),
                          ],
                  ),
                  TextSpan(
                    text: "매장 도착!",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
