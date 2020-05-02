// GlobalStats Class for GlobalView Screen
class GlobalStats {
  int updated;
  int cases;
  int todayCases;
  int todayDeaths;
  int deaths;
  int recovered;

  GlobalStats({
    this.updated,
    this.cases,
    this.todayCases,
    this.todayDeaths,
    this.deaths,
    this.recovered,
  });

  factory GlobalStats.fromJson(Map<String, dynamic> parsedJSON) => GlobalStats(
    updated: parsedJSON['updated'],
    cases: parsedJSON['cases'],
    todayCases: parsedJSON['todayCases'],
    todayDeaths: parsedJSON['todayDeaths'],
    deaths: parsedJSON['deaths'],
    recovered: parsedJSON['recovered'],
  );

  Map<String, dynamic> toJSON() => {
    'updated': updated,
    'cases': cases,
    'todayCases': todayCases,
    'todayDeaths': todayDeaths,
    'deaths': deaths,
    'recovered': recovered,
  };
}