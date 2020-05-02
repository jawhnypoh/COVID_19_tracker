// Utility to convert DateTime for calculating last updated from API

import 'package:jiffy/jiffy.dart';

class TimeSinceUpdatedConverter {
  String convertTimeStamp(int epochTimestamp) {
    final DateTime convertedTimeStamp = DateTime.fromMillisecondsSinceEpoch(epochTimestamp);
    print(convertedTimeStamp);
    return Jiffy(convertedTimeStamp).fromNow();
  }
}