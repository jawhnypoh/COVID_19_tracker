// StatesStats Class for an Individual State Screen
class StateStats {
  String state;
  int positive;
  int positiveScore;
  int negativeScore;
  int negativeRegularScore;
  int commercialScore;
  String grade;
  int score;
  String dataQualityGrade;
  int negative;
  dynamic pending;
  int hospitalizedCurrently;
  dynamic hospitalizedCumulative;
  dynamic inIcuCurrently;
  dynamic inIcuCumulative;
  dynamic onVentilatorCurrently;
  dynamic onVentilatorCumulative;
  int recovered;
  String lastUpdateEt;
  String checkTimeEt;
  int death;
  dynamic hospitalized;
  int total;
  int totalTestResults;
  int posNeg;
  String fips;
  DateTime dateModified;
  DateTime dateChecked;
  String hash;

  StateStats({
    this.state,
    this.positive,
    this.positiveScore,
    this.negativeScore,
    this.negativeRegularScore,
    this.commercialScore,
    this.grade,
    this.score,
    this.dataQualityGrade,
    this.negative,
    this.pending,
    this.hospitalizedCurrently,
    this.hospitalizedCumulative,
    this.inIcuCurrently,
    this.inIcuCumulative,
    this.onVentilatorCurrently,
    this.onVentilatorCumulative,
    this.recovered,
    this.lastUpdateEt,
    this.checkTimeEt,
    this.death,
    this.hospitalized,
    this.total,
    this.totalTestResults,
    this.posNeg,
    this.fips,
    this.dateModified,
    this.dateChecked,
    this.hash,
  });

  factory StateStats.fromJson(Map<String, dynamic> json) => StateStats(
    state: json["state"],
    positive: json["positive"],
    positiveScore: json["positiveScore"],
    negativeScore: json["negativeScore"],
    negativeRegularScore: json["negativeRegularScore"],
    commercialScore: json["commercialScore"],
    grade: json["grade"],
    score: json["score"],
    dataQualityGrade: json["dataQualityGrade"],
    negative: json["negative"],
    pending: json["pending"],
    hospitalizedCurrently: json["hospitalizedCurrently"],
    hospitalizedCumulative: json["hospitalizedCumulative"],
    inIcuCurrently: json["inIcuCurrently"],
    inIcuCumulative: json["inIcuCumulative"],
    onVentilatorCurrently: json["onVentilatorCurrently"],
    onVentilatorCumulative: json["onVentilatorCumulative"],
    recovered: json["recovered"],
    lastUpdateEt: json["lastUpdateEt"],
    checkTimeEt: json["checkTimeEt"],
    death: json["death"],
    hospitalized: json["hospitalized"],
    total: json["total"],
    totalTestResults: json["totalTestResults"],
    posNeg: json["posNeg"],
    fips: json["fips"],
    dateModified: DateTime.parse(json["dateModified"]),
    dateChecked: DateTime.parse(json["dateChecked"]),
    hash: json["hash"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "positive": positive,
    "positiveScore": positiveScore,
    "negativeScore": negativeScore,
    "negativeRegularScore": negativeRegularScore,
    "commercialScore": commercialScore,
    "grade": grade,
    "score": score,
    "dataQualityGrade": dataQualityGrade,
    "negative": negative,
    "pending": pending,
    "hospitalizedCurrently": hospitalizedCurrently,
    "hospitalizedCumulative": hospitalizedCumulative,
    "inIcuCurrently": inIcuCurrently,
    "inIcuCumulative": inIcuCumulative,
    "onVentilatorCurrently": onVentilatorCurrently,
    "onVentilatorCumulative": onVentilatorCumulative,
    "recovered": recovered,
    "lastUpdateEt": lastUpdateEt,
    "checkTimeEt": checkTimeEt,
    "death": death,
    "hospitalized": hospitalized,
    "total": total,
    "totalTestResults": totalTestResults,
    "posNeg": posNeg,
    "fips": fips,
    "dateModified": dateModified.toIso8601String(),
    "dateChecked": dateChecked.toIso8601String(),
    "hash": hash,
  };
}