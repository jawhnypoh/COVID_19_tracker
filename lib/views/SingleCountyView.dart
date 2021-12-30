// Single County Screen

import 'package:covid_19_tracker/charts/CountyHistoricalLineChart.dart';
import 'package:covid_19_tracker/models/us_county_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:covid_19_tracker/charts/LegendColoredBox.dart';

class SingleCountyViewState extends State<SingleCountyView> {
  USCountyStats countyStats;

  GoogleMapController mapController;
  Set<Marker> markerSet = Set();

  LatLng stateLatLng;

  var historicalLineChart;

  // Default location to Portland, OR if stateLatLng is null for some reason
  final LatLng _defaultLocation = const LatLng(45.521563, -122.677433);

  final numberFormatter = NumberFormat('#,###', 'en_US');

  SingleCountyViewState(this.countyStats);

  @override
  void initState() {
    historicalLineChart = CountyHistoricalLineChart.withHistoricalData(countyStats.county);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(countyStats.county + ' County'),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                _buildCountyMapWidget(countyStats.coordinates.latitude, countyStats.coordinates.longitude),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTotalCasesWidget(countyStats),
                    _buildTotalDeathsWidget(countyStats),
                  ],
                ),
                const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Container(
                  height: 200,
                  width: 350,
                  child: historicalLineChart,
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                _buildLineChartLegend(),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(100.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildTotalCasesWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(countyStats.stats.confirmed).toString(), style: TextStyle(fontSize: 50.0, color: Colors.orangeAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalDeathsWidget(countyStats) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(countyStats.stats.deaths).toString(), style: TextStyle(fontSize: 50.0, color: Colors.redAccent)),
                ]
            )
        )
    );
  }

  Widget _buildCountyMapWidget(lat, lng) {
    return Container(
      height: 300.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: GoogleMap(
//          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: LatLng(double.parse(lat), double.parse(lng)),
            zoom: 9,
        ),
      ),
    ));
  }

  Widget _buildLineChartLegend() {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LegendColoredBox(color: Colors.orangeAccent, text: 'Confirmed'),
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths')
          ],
        ),
      ),
    );
  }
}

class SingleCountyView extends StatefulWidget {
  // Declare countyStats that holds county info
  final USCountyStats countyStats;

  // Require countyStats in constructor
  SingleCountyView({Key key, @required this.countyStats}) : super(key : key);

  @override
  SingleCountyViewState createState() => SingleCountyViewState(countyStats);
}