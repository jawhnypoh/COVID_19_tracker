// Utility class for conversions and stuff
import 'package:flutter/material.dart';
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

  String convertDateTimeToStringNoDashes(DateTime dateTime) {
    return DateFormat('yyyyMMdd').format(dateTime);
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
      case 'S. Korea':
        return 'South Korea';
        break;
      default:
        return countryName;
    }
  }

  String convertRiskLevels(int riskLevel) {
    switch (riskLevel) {
      case 0:
        return 'Low Risk';
      case 1:
        return 'Medium Risk';
      case 2:
        return 'High Risk';
      case 3:
        return 'Extreme Risk';
      case 4:
        return 'Severe Risk';
      default:
        return 'NA';
    }
  }

  MaterialColor convertRiskLevelColors(int riskLevel) {
    switch (riskLevel) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      case 4:
        return Colors.red[900];
      default:
        return Colors.grey;
    }
  }

  int addTotalCounts(int active, int deaths, int recovered, int critical) {
    return active + deaths + recovered + critical;
  }

  int addTotalCountsForState(int active, int deaths, int recovered) {
    if (active != null && deaths != null || recovered != null) {
      return active + deaths + recovered;
    }
    return null;
  }

  String convertCountsToPercentages(int count, int totalCount) {
    return ((count / totalCount) * 100).toStringAsFixed(1);
  }

  String convertNumberToReadable(num count) {
    return NumberFormat.compact().format(count);
  }

  int calculateActiveCases(int confirmed, int deaths, int recovered) {
    if (confirmed != null && deaths != null && recovered != null) {
      return confirmed - (deaths + recovered);
    }
    return null;
  }
}