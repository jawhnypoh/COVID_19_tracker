// Utility class for conversions and stuff

import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class Utilities {
  String convertTimeStamp(int epochTimestamp) {
    final DateTime convertedTimeStamp = DateTime.fromMillisecondsSinceEpoch(epochTimestamp);
    return Jiffy(convertedTimeStamp).fromNow();
  }

  String convertDateTime(String dateTime) {
    return Jiffy(dateTime).yMMMd;
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
}