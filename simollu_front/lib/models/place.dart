class Place {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;

  Place({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  Place.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        name = json['place_name'],
        address = json['road_address_name'],
        lat = double.parse(json['y']),
        lng = double.parse(json['x']);
}
