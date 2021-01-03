// TestingCenter Class for Individual Testing Center Info
import 'dart:convert';

TestingCenter testingCenterFromJson(String str) => TestingCenter.fromJson(json.decode(str));

String testingCenterToJson(TestingCenter data) => json.encode(data.toJson());

class TestingCenter {
  String centerName;
  String address;
  String city;
  String state;
  String lat;
  double lon;
  String phone;
  String moreInfo;
  String driveThru;

  TestingCenter(
    {
      this.centerName,
      this.address,
      this.city,
      this.state,
      this.lat,
      this.lon,
      this.phone,
      this.moreInfo,
      this.driveThru
    });

  factory TestingCenter.fromJson(Map<String, dynamic> json) => TestingCenter(
    centerName: json['centername'],
    address: json['address'],
    city: json['city'],
    state: json['state'],
    lat: json['lat'],
    lon: json['lon'],
    phone: json['telephone'],
    moreInfo: json['moreinfo'],
    driveThru: json['drivethru']
  );

  Map<String, dynamic> toJson() => {
    'centername': centerName,
    'address': address,
    'city': city,
    'state': state,
    'lat': lat,
    'lon': lon,
    'phone': phone,
    'moreinfo': moreInfo,
    'drivetru': driveThru
  };
}