// StateLocation Class for State and its Latitude and Longitude
import 'dart:convert';

StateLocation stateLocationFromJson(String str) => StateLocation.fromJson(json.decode(str));

String stateLocationToJson(StateLocation data) => json.encode(data.toJson());

class StateLocation {
  String name;
  double lat;
  double lon;

  StateLocation(
    {
      this.name,
      this.lat,
      this.lon
    });

  factory StateLocation.fromJson(Map<String, dynamic> json) => StateLocation(
    name: json['state'],
    lat: json['latitude'],
    lon: json['longitude']
  );

  Map<String, dynamic> toJson() => {
    'state': name,
    'latitude': lat,
    'longitude': lon
  };
}