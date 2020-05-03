// TimelineDateModel Class for individual date in historical data
class TimelineDateModel {
  String date;
  int confirmed;
  int deaths;
  int recovered;

  TimelineDateModel({
    this.date,
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  factory TimelineDateModel.fromJson(Map<String, dynamic> parsedJSON) => TimelineDateModel(
    date: parsedJSON['date'],
    confirmed: parsedJSON['confirmed'],
    deaths: parsedJSON['deaths'],
    recovered: parsedJSON['recovered'],
  );

  Map<String, dynamic> toJSON() => {
    'date': date,
    'confirmed': confirmed,
    'deaths': deaths,
    'recovered': recovered,
  };
}