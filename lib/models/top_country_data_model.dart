// Data Type for different Top Countries

import 'package:charts_flutter/flutter.dart' as charts;

class TopCountry {
  final String countryName;
  final int count;
  final charts.Color barColor;

  TopCountry(this.countryName, this.count, this.barColor);
}