// Single State Screen

import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/charts/LegendColoredBox.dart';
import 'package:covid_19_tracker/charts/StateDonutPieChart.dart';
import 'package:covid_19_tracker/charts/StateHistoricalLineChart.dart';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:us_states/us_states.dart';

class SingleStateViewState extends State<SingleStateView> {
  StateStats stateStats;
  List countiesList;

  final numberFormatter = NumberFormat('#,###', 'en_US');
  var donutPieChart;
  var historicalLineChart;

  SingleStateViewState(this.stateStats, List countiesList);


  @override
  void initState() {
    if (stateStats.recovered != null) {
      donutPieChart = StateDonutPieChart.withCountsData(stateStats);
    }
    historicalLineChart = StateHistoricalLineChart.withHistoricalData(stateStats.state);

    print(countiesList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(USStates.getName(stateStats.state)),
      ),
      body: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildTotalTestedWidget(stateStats),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                _buildTotalCasesWidget(stateStats),
                const Padding(padding: EdgeInsets.only(top: 30.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTotalActive(stateStats),
                    _buildTotalDeaths(stateStats),
                    _buildTotalRecovered(stateStats),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                const Divider(color: Colors.grey),
                Container(
                  height: 300,
                  width: 400,
                  child: stateStats.recovered == null
                      ? const Center(
                          child: Text('Not enough data to generate Pie Chart',
                              style: TextStyle(color: Colors.grey)),
                        )
                      : donutPieChart,
                ),
                _buildPieChartLegend(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                Container(
                  height: 200,
                  width: 350,
                  child: historicalLineChart,
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                _buildLineChartLegend(),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                const Divider(color: Colors.grey),
                const Padding(padding: EdgeInsets.only(top: 10.0)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('state data updated ' + Utilities().convertDateTimeTimeStamp(stateStats.dateChecked),
                      style: const TextStyle(color: Colors.grey)),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
              ],
            ),
          )
        )
      )
    );
  }

  Widget _buildTotalTestedWidget(stateStat) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateStat.totalTestResults).toString(), style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalCasesWidget(stateStat) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateStat.positive).toString(), style: TextStyle(fontSize: 60.0, color: Colors.orangeAccent)),
                ]
            )
        )
    );
  }

  Widget _buildTotalActive(stateStat) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 110.0,
            maxWidth: 110.0,
            minHeight: 80.0,
            maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Active', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(Utilities().calculateActiveCases(stateStat.positive, stateStat.death, stateStat.recovered)  == null
                ? "N/A"
                : numberFormatter.format(Utilities().calculateActiveCases(stateStat.positive, stateStat.death, stateStat.recovered)).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.blueAccent), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRecovered(stateStat) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 110.0,
            maxWidth: 110.0,
            minHeight: 80.0,
            maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Recovered', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.recovered == null
                ? "N/A"
                : numberFormatter.format(stateStat.recovered).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.green), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalDeaths(stateStat) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 110.0,
            maxWidth: 110.0,
            minHeight: 80.0,
            maxHeight: 80.0
        ),
        child: Column(
          children: <Widget>[
            Text('Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(stateStat.death).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.redAccent), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChartLegend() {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LegendColoredBox(color: Colors.blueAccent, text: 'Active'),
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths'),
            LegendColoredBox(color: Colors.deepOrangeAccent, text: 'Critical'),
            LegendColoredBox(color: Colors.green, text: 'Recovered'),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChartLegend() {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            LegendColoredBox(color: Colors.orangeAccent, text: 'Confirmed'),
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths'),
            LegendColoredBox(color: Colors.green, text: 'Recovered'),
          ],
        ),
      ),
    );
  }
}

class SingleStateView extends StatefulWidget {
  // Declare stateName that holds state name
  final StateStats stateStats;
  final List countiesList;

  // Require stateName in constructor
  SingleStateView({Key key, @required this.stateStats, @required this.countiesList}) : super(key : key);

  @override
  SingleStateViewState createState() => SingleStateViewState(stateStats, countiesList);
}