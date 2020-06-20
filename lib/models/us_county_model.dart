// USCountyStats Class for an Individual US County Screen
class USCountyStats {
  String countyName;
  String stateName;
  int cases;
  int newCases;
  int deaths;
  int newDeaths;
  String fatalityRate;
  String updated;

  USCountyStats({
    this.countyName,
    this.stateName,
    this.cases,
    this.newCases,
    this.deaths,
    this.newDeaths,
    this.fatalityRate,
    this.updated
  });

  factory USCountyStats.fromJson(Map<String, dynamic> json) => USCountyStats(
    countyName: json["county_name"],
    stateName: json["state_name"],
    cases: json["confirmed"],
    newCases: json["new"],
    deaths: json["death"],
    newDeaths: json["new_death"],
    fatalityRate: json["fatality_rate"],
    updated: json["last_updated"]
  );

  Map<String, dynamic> toJson() => {
    "county_name": countyName,
    "state_name": stateName,
    "confirmed": cases,
    "new": newCases,
    "death": deaths,
    "new_death": newDeaths,
    "fatality_rate": fatalityRate,
    "last_updated": updated
  };
}