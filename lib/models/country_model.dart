// CountryStats Class for an Individual Country Screen
class CountryStats {
  int updated;
  String countryName;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  int tested;

  CountryStats({
    this.updated,
    this.countryName,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.critical,
    this.tested,
  });

  factory CountryStats.fromJson(Map<String, dynamic> parsedJSON) => CountryStats(
    updated: parsedJSON['updated'],
    countryName: parsedJSON['country'],
    cases: parsedJSON['cases'],
    todayCases: parsedJSON['todayCases'],
    deaths: parsedJSON['deaths'],
    todayDeaths: parsedJSON['todayDeaths'],
    recovered: parsedJSON['recovered'],
    active: parsedJSON['active'],
    critical: parsedJSON['critical'],
    tested: parsedJSON['tests'],
  );

  Map<String, dynamic> toJSON() => {
    'updated': updated,
    'countryName': countryName,
    'cases': cases,
    'todayCases': todayCases,
    'deaths': deaths,
    'todayDeaths': todayDeaths,
    'recovered': recovered,
    'active': active,
    'critical': critical,
    'tested': tested,
  };
}