// Single State Screen
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/views/SingleCountyView.dart';
import 'package:covid_19_tracker/views/CountiesListView.dart';
import 'package:covid_19_tracker/charts/LegendColoredBox.dart';
import 'package:covid_19_tracker/charts/StateDonutPieChart.dart';
import 'package:covid_19_tracker/charts/StateHistoricalLineChart.dart';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:us_states/us_states.dart';

class SingleStateViewState extends State<SingleStateView> {
  StateStats stateStats;

  final numberFormatter = NumberFormat('#,###', 'en_US');
  var donutPieChart;
  var historicalLineChart;

  SingleStateViewState(this.stateStats);

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    if (stateStats.recovered != null) {
      donutPieChart = StateDonutPieChart.withCountsData(stateStats);
    }
    historicalLineChart = StateHistoricalLineChart.withHistoricalData(stateStats.state);

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
            child: FutureBuilder<StateStats>(
              future: ApiResources().getSingleStateResults(stateStats.state),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        _buildTotalTestedWidget(stateStats),
                        const Padding(padding: EdgeInsets.only(top: 30.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildTotalCasesWidget(stateStats),
                            _buildTotalDeaths(stateStats),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildTotalActive(stateStats),
                            _buildTotalRecovered(stateStats),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildCurrentHospitalized(stateStats),
                            _buildCurrentICU(stateStats),
                            _buildCurrentVentilator(stateStats),
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
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        _buildCountiesContainer(),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
//                const Divider(color: Colors.grey),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: Text('state data updated ' + Utilities().convertDateTimeTimeStamp(stateStats.dateChecked),
//                      style: const TextStyle(color: Colors.grey)),
//                ),
//                const Padding(padding: EdgeInsets.only(top: 20.0)),
                      ],
                    ),
                  );
                }

                else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
        )
      )
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(
          minWidth: 150.0,
          maxWidth: 150.0,
          minHeight: 110.0,
          maxHeight: 110.0
        ),
        child: Column(
            children: <Widget>[
              Text('Confirmed', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
              Text(numberFormatter.format(stateStat.positive).toString(), style: TextStyle(fontSize: 40.0, color: Colors.orangeAccent)),
              Text('+' + numberFormatter.format(stateStat.positiveIncrease).toString() + ' Today',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent))
            ]
        )
      )
    );
  }

  Widget _buildTotalActive(stateStat) {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 150.0,
            maxWidth: 150.0,
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
            minWidth: 150.0,
            maxWidth: 150.0,
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
            minWidth: 150.0,
            maxWidth: 150.0,
            minHeight: 110.0,
            maxHeight: 110.0
        ),
        child: Column(
          children: <Widget>[
            Text('Deaths', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(numberFormatter.format(stateStat.death).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.redAccent), maxLines: 1),
            Text('+' + numberFormatter.format(stateStat.deathIncrease).toString() + ' Today',
                style: TextStyle(fontSize: 20.0, color: Colors.redAccent))
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentHospitalized(stateStat) {
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
            Text('Hospitalized', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.hospitalizedCurrently == null ? 'N/A' : numberFormatter.format(stateStat.hospitalizedCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.amber), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentICU(stateStat) {
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
            Text('Intensive Care', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.inIcuCurrently == null ? 'N/A' : numberFormatter.format(stateStat.inIcuCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.orange[800]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentVentilator(stateStat) {
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
            Text('On Ventilator', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.onVentilatorCurrently == null ? 'N/A' : numberFormatter.format(stateStat.onVentilatorCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.deepOrange[700]), maxLines: 1),
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

  Widget _buildCountiesContainer() {
    return Container(
      height: 310.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
//          Center(
//            child: Text('Top Counties', style: TextStyle(fontSize: 25.0, color: Colors.grey[350]))
//          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          FutureBuilder(
            future: ApiResources().getUSCountiesResults(USStates.getName(stateStats.state)),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? _buildCountiesResultsList(snapshot.data, USStates.getName(stateStats.state))
                  : _buildProgressIndicator();
            },
          ),
        ],
      )
    );
  }

  Widget _buildCountiesResultsList(List usCountiesList, String stateName) {
    return Expanded(
      child: ListView.separated(
        itemCount: usCountiesList == null ? 0 : 4,
        itemBuilder: (BuildContext context, int idx) {
          if (usCountiesList.isEmpty) {
            Text('No data found for counties',
                style: TextStyle(color: Colors.grey));
            return null;
          } else {
            return (idx == 3)
              ? Container(
                child: FlatButton(
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CountiesListView(
                            countiesList: usCountiesList,
                            stateName: stateName))
                    );
                  },
                  child: Text(
                    'See all counties',
                    style: TextStyle(fontSize: 15.0),
                  ),
                )
              )
              : ListTile(
                title: Text(usCountiesList[idx].countyName + ' County',
                    style: const TextStyle(fontSize: 25.0)),
                subtitle: Text(numberFormatter.format(usCountiesList[idx].cases).toString() + ' cases',
                    style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingleCountyView(countyStats: usCountiesList[idx]))
                  );
              },
            );
          }
        },
        separatorBuilder: (context, idx) {
          return Divider();
        },
        controller: _scrollController,
      ),
    );
  }
}

class SingleStateView extends StatefulWidget {
  // Declare stateStats that holds state info
  final StateStats stateStats;

  // Require statStats in constructor
  SingleStateView({Key key, @required this.stateStats}) : super(key : key);

  @override
  SingleStateViewState createState() => SingleStateViewState(stateStats);
}