class PathSegment {
  final int index;
  final List<List<double>> coordinates;
  final int time;
  final int distance;
  final String description;

  PathSegment({
    required this.index,
    required this.coordinates,
    required this.time,
    required this.distance,
    required this.description,
  });
/*
final List<List<double>> doubleList = dynamicList.map((dynamic row) {
    return List.castFrom(row).map<double>((dynamic element) => element as double).toList();
  }).toList();
*/
  PathSegment.fromPointJSON(Map<String, dynamic> json, List<double> coordinate)
      : this.index = json['properties']['index'],
        this.time = 0,
        this.coordinates = [coordinate],
        this.distance = 0,
        this.description = "경유지";

  PathSegment.fromJSON(Map<String, dynamic> json)
      : this.index = json['properties']['index'],
        this.coordinates = List<List<double>>.from(
          json['geometry']['coordinates'].map((dynamic point) {
            return List.castFrom(point)
                .map<double>((dynamic value) => value as double)
                .toList();
          }),
        ),
        this.time = json['properties']['time'],
        this.distance = json['properties']['distance'],
        this.description = json['properties']['description'];
}
