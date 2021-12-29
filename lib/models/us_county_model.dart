// USCountyStats Class for an Individual US County Screen
class USCountyStats {
  String country;
  String province;
  String county;
  String updatedAt;
  Stats stats;
  Coordinates coordinates;

  USCountyStats(
      {this.country,
        this.province,
        this.county,
        this.updatedAt,
        this.stats,
        this.coordinates});

  USCountyStats.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    province = json['province'];
    county = json['county'];
    updatedAt = json['updatedAt'];
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['province'] = this.province;
    data['county'] = this.county;
    data['updatedAt'] = this.updatedAt;
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    return data;
  }
}

class Stats {
  int confirmed;
  int deaths;

  Stats({this.confirmed, this.deaths});

  Stats.fromJson(Map<String, dynamic> json) {
    confirmed = json['confirmed'];
    deaths = json['deaths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed'] = this.confirmed;
    data['deaths'] = this.deaths;
    return data;
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}