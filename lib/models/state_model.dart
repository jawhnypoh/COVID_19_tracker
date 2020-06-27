// StatesStats Class for an Individual State Screen
class StateStats {
  int date;
  String state;
  int positive;
  int negative;
  int pending;
  int hospitalizedCurrently;
  int hospitalizedCumulative;
  int inIcuCurrently;
  int inIcuCumulative;
  int onVentilatorCurrently;
  int onVentilatorCumulative;
  int recovered;
  String dataQualityGrade;
  String lastUpdateEt;
  String dateModified;
  String checkTimeEt;
  int death;
  int hospitalized;
  String dateChecked;
  int totalTestsViral;
  int positiveTestsViral;
  int negativeTestsViral;
  int positiveCasesViral;
  String fips;
  int positiveIncrease;
  int negativeIncrease;
  int total;
  int totalTestResults;
  int totalTestResultsIncrease;
  int posNeg;
  int deathIncrease;
  int hospitalizedIncrease;
  String hash;
  int commercialScore;
  int negativeRegularScore;
  int negativeScore;
  int positiveScore;
  int score;
  String grade;

  StateStats(
      {this.date,
        this.state,
        this.positive,
        this.negative,
        this.pending,
        this.hospitalizedCurrently,
        this.hospitalizedCumulative,
        this.inIcuCurrently,
        this.inIcuCumulative,
        this.onVentilatorCurrently,
        this.onVentilatorCumulative,
        this.recovered,
        this.dataQualityGrade,
        this.lastUpdateEt,
        this.dateModified,
        this.checkTimeEt,
        this.death,
        this.hospitalized,
        this.dateChecked,
        this.totalTestsViral,
        this.positiveTestsViral,
        this.negativeTestsViral,
        this.positiveCasesViral,
        this.fips,
        this.positiveIncrease,
        this.negativeIncrease,
        this.total,
        this.totalTestResults,
        this.totalTestResultsIncrease,
        this.posNeg,
        this.deathIncrease,
        this.hospitalizedIncrease,
        this.hash,
        this.commercialScore,
        this.negativeRegularScore,
        this.negativeScore,
        this.positiveScore,
        this.score,
        this.grade});

  StateStats.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    state = json['state'];
    positive = json['positive'];
    negative = json['negative'];
    pending = json['pending'];
    hospitalizedCurrently = json['hospitalizedCurrently'];
    hospitalizedCumulative = json['hospitalizedCumulative'];
    inIcuCurrently = json['inIcuCurrently'];
    inIcuCumulative = json['inIcuCumulative'];
    onVentilatorCurrently = json['onVentilatorCurrently'];
    onVentilatorCumulative = json['onVentilatorCumulative'];
    recovered = json['recovered'];
    dataQualityGrade = json['dataQualityGrade'];
    lastUpdateEt = json['lastUpdateEt'];
    dateModified = json['dateModified'];
    checkTimeEt = json['checkTimeEt'];
    death = json['death'];
    hospitalized = json['hospitalized'];
    dateChecked = json['dateChecked'];
    totalTestsViral = json['totalTestsViral'];
    positiveTestsViral = json['positiveTestsViral'];
    negativeTestsViral = json['negativeTestsViral'];
    positiveCasesViral = json['positiveCasesViral'];
    fips = json['fips'];
    positiveIncrease = json['positiveIncrease'];
    negativeIncrease = json['negativeIncrease'];
    total = json['total'];
    totalTestResults = json['totalTestResults'];
    totalTestResultsIncrease = json['totalTestResultsIncrease'];
    posNeg = json['posNeg'];
    deathIncrease = json['deathIncrease'];
    hospitalizedIncrease = json['hospitalizedIncrease'];
    hash = json['hash'];
    commercialScore = json['commercialScore'];
    negativeRegularScore = json['negativeRegularScore'];
    negativeScore = json['negativeScore'];
    positiveScore = json['positiveScore'];
    score = json['score'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['state'] = this.state;
    data['positive'] = this.positive;
    data['negative'] = this.negative;
    data['pending'] = this.pending;
    data['hospitalizedCurrently'] = this.hospitalizedCurrently;
    data['hospitalizedCumulative'] = this.hospitalizedCumulative;
    data['inIcuCurrently'] = this.inIcuCurrently;
    data['inIcuCumulative'] = this.inIcuCumulative;
    data['onVentilatorCurrently'] = this.onVentilatorCurrently;
    data['onVentilatorCumulative'] = this.onVentilatorCumulative;
    data['recovered'] = this.recovered;
    data['dataQualityGrade'] = this.dataQualityGrade;
    data['lastUpdateEt'] = this.lastUpdateEt;
    data['dateModified'] = this.dateModified;
    data['checkTimeEt'] = this.checkTimeEt;
    data['death'] = this.death;
    data['hospitalized'] = this.hospitalized;
    data['dateChecked'] = this.dateChecked;
    data['totalTestsViral'] = this.totalTestsViral;
    data['positiveTestsViral'] = this.positiveTestsViral;
    data['negativeTestsViral'] = this.negativeTestsViral;
    data['positiveCasesViral'] = this.positiveCasesViral;
    data['fips'] = this.fips;
    data['positiveIncrease'] = this.positiveIncrease;
    data['negativeIncrease'] = this.negativeIncrease;
    data['total'] = this.total;
    data['totalTestResults'] = this.totalTestResults;
    data['totalTestResultsIncrease'] = this.totalTestResultsIncrease;
    data['posNeg'] = this.posNeg;
    data['deathIncrease'] = this.deathIncrease;
    data['hospitalizedIncrease'] = this.hospitalizedIncrease;
    data['hash'] = this.hash;
    data['commercialScore'] = this.commercialScore;
    data['negativeRegularScore'] = this.negativeRegularScore;
    data['negativeScore'] = this.negativeScore;
    data['positiveScore'] = this.positiveScore;
    data['score'] = this.score;
    data['grade'] = this.grade;
    return data;
  }
}