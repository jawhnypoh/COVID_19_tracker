// StatesStats Class for an Individual State Screen
class StateStats {
  String stateName;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int active;
  int tested;

  StateStats({
    this.stateName,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.active,
    this.tested,
  });

  factory StateStats.fromJson(Map<String, dynamic> parsedJSON) => StateStats(
    stateName: parsedJSON['state'],
    cases: parsedJSON['cases'],
    todayCases: parsedJSON['todayCases'],
    deaths: parsedJSON['deaths'],
    todayDeaths: parsedJSON['todayDeaths'],
    active: parsedJSON['active'],
    tested: parsedJSON['tests'],
  );

  Map<String, dynamic> toJSON() => {
    'stateName': stateName,
    'cases': cases,
    'todayCases': todayCases,
    'deaths': deaths,
    'todayDeaths': todayDeaths,
    'active': active,
    'tested': tested,
  };
}