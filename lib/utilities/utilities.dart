// Utility class for conversions and stuff

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Utilities {
  String convertEpochTimeStamp(int epochTimestamp) {
    final DateTime convertedTimeStamp = DateTime.fromMillisecondsSinceEpoch(epochTimestamp);
    return Jiffy(convertedTimeStamp).fromNow();
  }

  String convertDateTimeTimeStamp(String dateTime) {
    return Jiffy(dateTime).fromNow();
  }

  String convertDateTime(String dateTime) {
    return Jiffy(dateTime).yMMMd;
  }

  DateTime convertStringToDateTime(String dateTime) {
    return DateTime.parse(dateTime);
  }

  String convertToFullName(String countryName) {
    switch (countryName) {
      case 'USA':
        return 'United States';
        break;
      case 'UK':
        return 'United Kingdom';
        break;
      case 'UAE':
        return 'United Arab Emirates';
        break;
      default:
        return countryName;
    }
  }

  int addTotalCounts(int active, int deaths, int recovered) {
    return active + deaths + recovered;
  }

  String convertCountsToPercentages(int count, int totalCount) {
    return ((count / totalCount) * 100).toStringAsFixed(1);
  }

  String convertNumberToReadable(num count) {
    return NumberFormat.compact().format(count);
  }

  int calculateTotalActiveCases(int confirmed, int deaths, int recovered) {
    return confirmed - (deaths + recovered);
  }
}