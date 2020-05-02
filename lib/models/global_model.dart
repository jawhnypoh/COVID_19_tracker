// GlobalStats Class for GlobalView Screen
class GlobalStats {
  int updated;
  int cases;
  int active;
  int critical;
  int todayCases;
  int todayDeaths;
  int deaths;
  int recovered;
  int affectedCountries;

  GlobalStats({
    this.updated,
    this.cases,
    this.active,
    this.critical,
    this.todayCases,
    this.todayDeaths,
    this.deaths,
    this.recovered,
    this.affectedCountries,
  });

  factory GlobalStats.fromJson(Map<String, dynamic> parsedJSON) => GlobalStats(
    updated: parsedJSON['updated'],
    cases: parsedJSON['cases'],
    active: parsedJSON['active'],
    critical: parsedJSON['critical'],
    todayCases: parsedJSON['todayCases'],
    todayDeaths: parsedJSON['todayDeaths'],
    deaths: parsedJSON['deaths'],
    recovered: parsedJSON['recovered'],
    affectedCountries: parsedJSON['affectedCountries'],
  );

  Map<String, dynamic> toJSON() => {
    'updated': updated,
    'cases': cases,
    'active': active,
    'critical': critical,
    'todayCases': todayCases,
    'todayDeaths': todayDeaths,
    'deaths': deaths,
    'recovered': recovered,
    'affectedCountries': affectedCountries,
  };
}