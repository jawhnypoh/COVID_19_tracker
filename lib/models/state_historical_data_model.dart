// StateHistoricalSTats for Individual State's Historical Data Screen
class StateHistoricalStats {
  int date;
  String state;
  int positive;
  int probableCases;
  String totalTestResultsSource;
  int totalTestResults;
  int hospitalizedCurrently;
  int hospitalizedCumulative;
  int inIcuCurrently;
  int inIcuCumulative;
  int onVentilatorCurrently;
  int onVentilatorCumulative;
  int recovered;
  String lastUpdateEt;
  String dateModified;
  String checkTimeEt;
  int death;
  int hospitalized;
  int hospitalizedDischarged;
  String dateChecked;
  int positiveCasesViral;
  int deathConfirmed;
  int totalTestEncountersViral;
  String fips;
  int positiveIncrease;
  int negativeIncrease;
  int total;
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

  StateHistoricalStats(
      {this.date,
        this.state,
        this.positive,
        this.probableCases,
        this.totalTestResultsSource,
        this.totalTestResults,
        this.hospitalizedCurrently,
        this.hospitalizedCumulative,
        this.inIcuCurrently,
        this.inIcuCumulative,
        this.onVentilatorCurrently,
        this.onVentilatorCumulative,
        this.recovered,
        this.lastUpdateEt,
        this.dateModified,
        this.checkTimeEt,
        this.death,
        this.hospitalized,
        this.hospitalizedDischarged,
        this.dateChecked,
        this.positiveCasesViral,
        this.deathConfirmed,
        this.totalTestEncountersViral,
        this.fips,
        this.positiveIncrease,
        this.negativeIncrease,
        this.total,
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

  StateHistoricalStats.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    state = json['state'];
    positive = json['positive'];
    probableCases = json['probableCases'];
    totalTestResultsSource = json['totalTestResultsSource'];
    totalTestResults = json['totalTestResults'];
    hospitalizedCurrently = json['hospitalizedCurrently'];
    hospitalizedCumulative = json['hospitalizedCumulative'];
    inIcuCurrently = json['inIcuCurrently'];
    inIcuCumulative = json['inIcuCumulative'];
    onVentilatorCurrently = json['onVentilatorCurrently'];
    onVentilatorCumulative = json['onVentilatorCumulative'];
    recovered = json['recovered'];
    lastUpdateEt = json['lastUpdateEt'];
    dateModified = json['dateModified'];
    checkTimeEt = json['checkTimeEt'];
    death = json['death'];
    hospitalized = json['hospitalized'];
    hospitalizedDischarged = json['hospitalizedDischarged'];
    dateChecked = json['dateChecked'];
    positiveCasesViral = json['positiveCasesViral'];
    deathConfirmed = json['deathConfirmed'];
    totalTestEncountersViral = json['totalTestEncountersViral'];
    fips = json['fips'];
    positiveIncrease = json['positiveIncrease'];
    negativeIncrease = json['negativeIncrease'];
    total = json['total'];
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
    data['probableCases'] = this.probableCases;
    data['totalTestResultsSource'] = this.totalTestResultsSource;
    data['totalTestResults'] = this.totalTestResults;
    data['hospitalizedCurrently'] = this.hospitalizedCurrently;
    data['hospitalizedCumulative'] = this.hospitalizedCumulative;
    data['inIcuCurrently'] = this.inIcuCurrently;
    data['inIcuCumulative'] = this.inIcuCumulative;
    data['onVentilatorCurrently'] = this.onVentilatorCurrently;
    data['onVentilatorCumulative'] = this.onVentilatorCumulative;
    data['recovered'] = this.recovered;
    data['lastUpdateEt'] = this.lastUpdateEt;
    data['dateModified'] = this.dateModified;
    data['checkTimeEt'] = this.checkTimeEt;
    data['death'] = this.death;
    data['hospitalized'] = this.hospitalized;
    data['hospitalizedDischarged'] = this.hospitalizedDischarged;
    data['dateChecked'] = this.dateChecked;
    data['positiveCasesViral'] = this.positiveCasesViral;
    data['deathConfirmed'] = this.deathConfirmed;
    data['totalTestEncountersViral'] = this.totalTestEncountersViral;
    data['fips'] = this.fips;
    data['positiveIncrease'] = this.positiveIncrease;
    data['negativeIncrease'] = this.negativeIncrease;
    data['total'] = this.total;
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
