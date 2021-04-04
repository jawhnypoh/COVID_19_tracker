// StatesStats Class for an Individual State Screen
class StateStats {
  String fips;
  String country;
  String state;
  String county;
  String level;
  int lat;
  String locationId;
  int long;
  int population;
  Metrics metrics;
  RiskLevels riskLevels;
  Actuals actuals;
  String lastUpdatedDate;

  StateStats(
      {this.fips,
        this.country,
        this.state,
        this.county,
        this.level,
        this.lat,
        this.locationId,
        this.long,
        this.population,
        this.metrics,
        this.riskLevels,
        this.actuals,
        this.lastUpdatedDate});

  StateStats.fromJson(Map<String, dynamic> json) {
    fips = json['fips'];
    country = json['country'];
    state = json['state'];
    county = json['county'];
    level = json['level'];
    lat = json['lat'];
    locationId = json['locationId'];
    long = json['long'];
    population = json['population'];
    metrics =
    json['metrics'] != null ? new Metrics.fromJson(json['metrics']) : null;
    riskLevels = json['riskLevels'] != null
        ? new RiskLevels.fromJson(json['riskLevels'])
        : null;
    actuals =
    json['actuals'] != null ? new Actuals.fromJson(json['actuals']) : null;
    lastUpdatedDate = json['lastUpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fips'] = this.fips;
    data['country'] = this.country;
    data['state'] = this.state;
    data['county'] = this.county;
    data['level'] = this.level;
    data['lat'] = this.lat;
    data['locationId'] = this.locationId;
    data['long'] = this.long;
    data['population'] = this.population;
    if (this.metrics != null) {
      data['metrics'] = this.metrics.toJson();
    }
    if (this.riskLevels != null) {
      data['riskLevels'] = this.riskLevels.toJson();
    }
    if (this.actuals != null) {
      data['actuals'] = this.actuals.toJson();
    }
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    return data;
  }
}

class Metrics {
  dynamic testPositivityRatio;
  dynamic caseDensity;
  dynamic contactTracerCapacityRatio;
  dynamic infectionRate;
  dynamic icuHeadroomRatio;
  IcuHeadroomDetails icuHeadroomDetails;
  dynamic icuCapacityRatio;
  dynamic vaccinationsInitiatedRatio;
  dynamic vaccinationsCompletedRatio;

  Metrics(
      {this.testPositivityRatio,
        this.caseDensity,
        this.contactTracerCapacityRatio,
        this.infectionRate,
        this.icuHeadroomRatio,
        this.icuHeadroomDetails,
        this.icuCapacityRatio,
        this.vaccinationsInitiatedRatio,
        this.vaccinationsCompletedRatio});

  Metrics.fromJson(Map<String, dynamic> json) {
    testPositivityRatio = json['testPositivityRatio'];
    caseDensity = json['caseDensity'];
    contactTracerCapacityRatio = json['contactTracerCapacityRatio'];
    infectionRate = json['infectionRate'];
    icuHeadroomRatio = json['icuHeadroomRatio'];
    icuHeadroomDetails = json['icuHeadroomDetails'] != null
        ? new IcuHeadroomDetails.fromJson(json['icuHeadroomDetails'])
        : null;
    icuCapacityRatio = json['icuCapacityRatio'];
    vaccinationsInitiatedRatio = json['vaccinationsInitiatedRatio'];
    vaccinationsCompletedRatio = json['vaccinationsCompletedRatio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testPositivityRatio'] = this.testPositivityRatio;
    data['caseDensity'] = this.caseDensity;
    data['contactTracerCapacityRatio'] = this.contactTracerCapacityRatio;
    data['infectionRate'] = this.infectionRate;
    data['icuHeadroomRatio'] = this.icuHeadroomRatio;
    if (this.icuHeadroomDetails != null) {
      data['icuHeadroomDetails'] = this.icuHeadroomDetails.toJson();
    }
    data['icuCapacityRatio'] = this.icuCapacityRatio;
    data['vaccinationsInitiatedRatio'] = this.vaccinationsInitiatedRatio;
    data['vaccinationsCompletedRatio'] = this.vaccinationsCompletedRatio;
    return data;
  }
}

class IcuHeadroomDetails {
  int currentIcuCovid;
  String currentIcuCovidMethod;
  int currentIcuNonCovid;
  String currentIcuNonCovidMethod;

  IcuHeadroomDetails(
      {this.currentIcuCovid,
        this.currentIcuCovidMethod,
        this.currentIcuNonCovid,
        this.currentIcuNonCovidMethod});

  IcuHeadroomDetails.fromJson(Map<String, dynamic> json) {
    currentIcuCovid = json['currentIcuCovid'];
    currentIcuCovidMethod = json['currentIcuCovidMethod'];
    currentIcuNonCovid = json['currentIcuNonCovid'];
    currentIcuNonCovidMethod = json['currentIcuNonCovidMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currentIcuCovid'] = this.currentIcuCovid;
    data['currentIcuCovidMethod'] = this.currentIcuCovidMethod;
    data['currentIcuNonCovid'] = this.currentIcuNonCovid;
    data['currentIcuNonCovidMethod'] = this.currentIcuNonCovidMethod;
    return data;
  }
}

class RiskLevels {
  int overall;
  dynamic testPositivityRatio;
  int caseDensity;
  int contactTracerCapacityRatio;
  int infectionRate;
  int icuHeadroomRatio;
  int icuCapacityRatio;

  RiskLevels(
      {this.overall,
        this.testPositivityRatio,
        this.caseDensity,
        this.contactTracerCapacityRatio,
        this.infectionRate,
        this.icuHeadroomRatio,
        this.icuCapacityRatio});

  RiskLevels.fromJson(Map<String, dynamic> json) {
    overall = json['overall'];
    testPositivityRatio = json['testPositivityRatio'];
    caseDensity = json['caseDensity'];
    contactTracerCapacityRatio = json['contactTracerCapacityRatio'];
    infectionRate = json['infectionRate'];
    icuHeadroomRatio = json['icuHeadroomRatio'];
    icuCapacityRatio = json['icuCapacityRatio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['overall'] = this.overall;
    data['testPositivityRatio'] = this.testPositivityRatio;
    data['caseDensity'] = this.caseDensity;
    data['contactTracerCapacityRatio'] = this.contactTracerCapacityRatio;
    data['infectionRate'] = this.infectionRate;
    data['icuHeadroomRatio'] = this.icuHeadroomRatio;
    data['icuCapacityRatio'] = this.icuCapacityRatio;
    return data;
  }
}

class Actuals {
  int cases;
  int deaths;
  int positiveTests;
  int negativeTests;
  int contactTracers;
  HospitalBeds hospitalBeds;
  HospitalBeds icuBeds;
  int newCases;
  int newDeaths;
  int vaccinesDistributed;
  int vaccinationsInitiated;
  int vaccinationsCompleted;
  int vaccinesAdministered;

  Actuals(
      {this.cases,
        this.deaths,
        this.positiveTests,
        this.negativeTests,
        this.contactTracers,
        this.hospitalBeds,
        this.icuBeds,
        this.newCases,
        this.newDeaths,
        this.vaccinesDistributed,
        this.vaccinationsInitiated,
        this.vaccinationsCompleted,
        this.vaccinesAdministered});

  Actuals.fromJson(Map<String, dynamic> json) {
    cases = json['cases'];
    deaths = json['deaths'];
    positiveTests = json['positiveTests'];
    negativeTests = json['negativeTests'];
    contactTracers = json['contactTracers'];
    hospitalBeds = json['hospitalBeds'] != null
        ? new HospitalBeds.fromJson(json['hospitalBeds'])
        : null;
    icuBeds = json['icuBeds'] != null
        ? new HospitalBeds.fromJson(json['icuBeds'])
        : null;
    newCases = json['newCases'];
    newDeaths = json['newDeaths'];
    vaccinesDistributed = json['vaccinesDistributed'];
    vaccinationsInitiated = json['vaccinationsInitiated'];
    vaccinationsCompleted = json['vaccinationsCompleted'];
    vaccinesAdministered = json['vaccinesAdministered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cases'] = this.cases;
    data['deaths'] = this.deaths;
    data['positiveTests'] = this.positiveTests;
    data['negativeTests'] = this.negativeTests;
    data['contactTracers'] = this.contactTracers;
    if (this.hospitalBeds != null) {
      data['hospitalBeds'] = this.hospitalBeds.toJson();
    }
    if (this.icuBeds != null) {
      data['icuBeds'] = this.icuBeds.toJson();
    }
    data['newCases'] = this.newCases;
    data['newDeaths'] = this.newDeaths;
    data['vaccinesDistributed'] = this.vaccinesDistributed;
    data['vaccinationsInitiated'] = this.vaccinationsInitiated;
    data['vaccinationsCompleted'] = this.vaccinationsCompleted;
    data['vaccinesAdministered'] = this.vaccinesAdministered;
    return data;
  }
}

class HospitalBeds {
  int capacity;
  int currentUsageTotal;
  int currentUsageCovid;
  double typicalUsageRate;

  HospitalBeds(
      {this.capacity,
        this.currentUsageTotal,
        this.currentUsageCovid,
        this.typicalUsageRate});

  HospitalBeds.fromJson(Map<String, dynamic> json) {
    capacity = json['capacity'];
    currentUsageTotal = json['currentUsageTotal'];
    currentUsageCovid = json['currentUsageCovid'];
    typicalUsageRate = json['typicalUsageRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capacity'] = this.capacity;
    data['currentUsageTotal'] = this.currentUsageTotal;
    data['currentUsageCovid'] = this.currentUsageCovid;
    data['typicalUsageRate'] = this.typicalUsageRate;
    return data;
  }
}
