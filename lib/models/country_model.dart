// CountryStats Class for an Individual Country Screen
class CountryStats {
  Data data;

  CountryStats({
    this.data,
  });

  factory CountryStats.fromJson(Map<String, dynamic> json) => CountryStats(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String code;
  int population;
  String updatedAt;
  Today today;
  LatestData latestData;
  List<Timeline> timeline;

  Data({
    this.name,
    this.code,
    this.population,
    this.updatedAt,
    this.today,
    this.latestData,
    this.timeline,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    code: json["code"],
    population: json["population"],
    updatedAt: json["updated_at"],
    today: Today.fromJson(json["today"]),
    latestData: LatestData.fromJson(json["latest_data"]),
    timeline: List<Timeline>.from(json["timeline"].map((x) => Timeline.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
    "population": population,
    "updated_at": updatedAt,
    "today": today.toJson(),
    "latest_data": latestData.toJson(),
    "timeline": List<dynamic>.from(timeline.map((x) => x.toJson())),
  };
}

class LatestData {
  int deaths;
  int confirmed;
  int recovered;
  int critical;
  Calculated calculated;

  LatestData({
    this.deaths,
    this.confirmed,
    this.recovered,
    this.critical,
    this.calculated,
  });

  factory LatestData.fromJson(Map<String, dynamic> json) => LatestData(
    deaths: json["deaths"],
    confirmed: json["confirmed"],
    recovered: json["recovered"],
    critical: json["critical"],
    calculated: Calculated.fromJson(json["calculated"]),
  );

  Map<String, dynamic> toJson() => {
    "deaths": deaths,
    "confirmed": confirmed,
    "recovered": recovered,
    "critical": critical,
    "calculated": calculated.toJson(),
  };
}

class Calculated {
  double deathRate;
  double recoveryRate;
  dynamic recoveredVsDeathRatio;
  int casesPerMillionPopulation;

  Calculated({
    this.deathRate,
    this.recoveryRate,
    this.recoveredVsDeathRatio,
    this.casesPerMillionPopulation,
  });

  factory Calculated.fromJson(Map<String, dynamic> json) => Calculated(
    deathRate: json["death_rate"] == null ? null : json["death_rate"].toDouble(),
    recoveryRate: json["recovery_rate"] == null ? null : json["recovery_rate"].toDouble(),
    recoveredVsDeathRatio: json["recovered_vs_death_ratio"],
    casesPerMillionPopulation: json["cases_per_million_population"],
  );

  Map<String, dynamic> toJson() => {
    "death_rate": deathRate,
    "recovery_rate": recoveryRate,
    "recovered_vs_death_ratio": recoveredVsDeathRatio,
    "cases_per_million_population": casesPerMillionPopulation,
  };
}

class Timeline {
  DateTime updatedAt;
  DateTime date;
  int deaths;
  int confirmed;
  int active;
  int recovered;
  int newConfirmed;
  int newRecovered;
  int newDeaths;
  bool isInProgress;

  Timeline({
    this.updatedAt,
    this.date,
    this.deaths,
    this.confirmed,
    this.active,
    this.recovered,
    this.newConfirmed,
    this.newRecovered,
    this.newDeaths,
    this.isInProgress,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    updatedAt: DateTime.parse(json["updated_at"]),
    date: DateTime.parse(json["date"]),
    deaths: json["deaths"],
    confirmed: json["confirmed"],
    active: json["active"],
    recovered: json["recovered"],
    newConfirmed: json["new_confirmed"],
    newRecovered: json["new_recovered"],
    newDeaths: json["new_deaths"],
    isInProgress: json["is_in_progress"] == null ? null : json["is_in_progress"],
  );

  Map<String, dynamic> toJson() => {
    "updated_at": updatedAt.toIso8601String(),
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "deaths": deaths,
    "confirmed": confirmed,
    "active": active,
    "recovered": recovered,
    "new_confirmed": newConfirmed,
    "new_recovered": newRecovered,
    "new_deaths": newDeaths,
    "is_in_progress": isInProgress == null ? null : isInProgress,
  };
}

class Today {
  int deaths;
  int confirmed;

  Today({
    this.deaths,
    this.confirmed,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    deaths: json["deaths"],
    confirmed: json["confirmed"],
  );

  Map<String, dynamic> toJson() => {
    "deaths": deaths,
    "confirmed": confirmed,
  };
}