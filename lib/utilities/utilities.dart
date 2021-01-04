// Utility class for conversions and stuff
import 'dart:convert';
import 'package:covid_19_tracker/models/state_location_model.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/services.dart';

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
      case 'S. Korea':
        return 'South Korea';
        break;
      default:
        return countryName;
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