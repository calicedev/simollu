class AddressModel {
  final String addressName;
  final String region1DepthName;
  final String region2DepthName;
  final String region3DepthName;
  final String mountainYn;
  final String mainAddressNo;
  final String subAddressNo;

  AddressModel({
    required this.addressName,
    required this.region1DepthName,
    required this.region2DepthName,
    required this.region3DepthName,
    required this.mountainYn,
    required this.mainAddressNo,
    required this.subAddressNo,
  });

  AddressModel.fromJSON(Map<String, dynamic> json)
      : this.addressName = json['address_name'],
        this.region1DepthName = json['region_1depth_name'],
        this.region2DepthName = json['region_2depth_name'],
        this.region3DepthName = json['region_3depth_name'],
        this.mountainYn = json['mountain_yn'],
        this.mainAddressNo = json['main_address_no'],
        this.subAddressNo = json['sub_address_no'];
}
