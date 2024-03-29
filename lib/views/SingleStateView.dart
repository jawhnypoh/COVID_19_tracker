// Single State Screen
import 'dart:collection';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_19_tracker/models/state_location_model.dart';
import 'package:covid_19_tracker/views/NewsURLView.dart';
import 'package:covid_19_tracker/views/MapView.dart';
import 'package:covid_19_tracker/views/SingleCountyView.dart';
import 'package:covid_19_tracker/charts/LegendColoredBox.dart';
import 'package:covid_19_tracker/charts/StateHistoricalLineChart.dart';
import 'package:covid_19_tracker/models/state_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:covid_19_tracker/views/StateHistoricalDataView.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:covid_19_tracker/utilities/utilities.dart';
import 'package:jiffy/jiffy.dart';
import 'package:us_states/us_states.dart';

class SingleStateViewState extends State<SingleStateView> {
  StateStats stateStats;

  final numberFormatter = NumberFormat('#,###', 'en_US');
  final percentFormatter = NumberFormat('###.0', 'en_US');

  var donutPieChart;
  var historicalLineChart;

  StateLocation stateLatLng;

  SingleStateViewState(this.stateStats);

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
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
          child: SingleChildScrollView(
            child: FutureBuilder<StateStats>(
              future: ApiResources().getSingleStateResults(stateStats.state),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildGetTestBanner(stateStats.state),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        _buildRiskLevelWidget(stateStats),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                        const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
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
                            _buildCurrentHospitalized(stateStats),
                            _buildCurrentICU(stateStats)
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _buildInfectionRate(stateStats),
                            _buildIcuCapUsed(stateStats),
                            _buildVaccinated(stateStats)
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
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
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                          ),
                          onPressed: () {
                            // selectedDate is one month before current date for dataset purposes
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    StateHistoricalDataView(stateAbr: stateStats.state,
                                        selectedDate: Jiffy(DateTime.now()).subtract(months: 1)
                                ))
                            );
                          },
                          child: Text('See Detailed Historical Data'),
                        ),
                        const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                        const Padding(padding: EdgeInsets.only(top: 20.0)),
                        _buildCountiesContainer(),
                        const Padding(padding: EdgeInsets.only(top: 10.0)),
                        const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('state data updated ' + Utilities()
                      .convertDateTimeTimeStamp(stateStats.lastUpdatedDate),
                      style: const TextStyle(color: Colors.grey)),
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
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

  Widget _buildGetTestBanner(String stateName) {
    return Container(
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/stateLocations.json'),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Container(height: 150.0,);
          }
          
          return MaterialBanner(
            content: Text('COVID-19 vaccines are now available for free at health care centers, clinics, and retail pharmacies nationwide. '
                'Visit the state health department\'\s website for the latest information on vaccines. '),
            leading: Icon(Icons.info),
            actions: [
              FlatButton(
                child: const Text('LEARN MORE'),
                onPressed: () {
                // Go to CDC website about US COVID Testing
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      NewsURLView(newsURL: 'https://www.cdc.gov/coronavirus/2019-ncov/vaccines/keythingstoknow.html'))
                  );
                },
              ),
              FlatButton(
              child: Text('GET VACCINATED'),
                onPressed: () {
                  // Go to Testing Centers Map View
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      MapView(stateAbr: stateStats.state,
                          stateLatLng: findStateLatLng(snapshot, stateName)))
                 );
                },
              )
            ]
          );
        },
      )
    );
  }

  Widget _buildRiskLevelWidget(stateStats) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.solidCircle,
                color: Utilities().convertRiskLevelColors(
                    stateStats.riskLevels.overall)),
            Text(' ' + Utilities().convertRiskLevels(stateStats.riskLevels.overall),
                style: TextStyle(fontSize: 25.0, color: Colors.grey[350]))
          ],
        ),
      ),
    );
  }

  Widget _buildTotalTestedWidget(stateStat) {
    return Container(
    child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateStat.actuals.positiveTests + stateStat.actuals.negativeTests).toString(),
                      style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),

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
              AutoSizeText(numberFormatter.format(stateStat.actuals.cases).toString(),
                  style: TextStyle(fontSize: 40.0, color: Colors.orangeAccent), maxLines: 1),
              Text('+' + numberFormatter.format(stateStat.actuals.newCases).toString() + ' Today',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent))
            ]
        )
      )
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
            AutoSizeText(numberFormatter.format(stateStat.actuals.deaths).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.redAccent), maxLines: 1),
            Text('+' + numberFormatter.format(stateStat.actuals.newDeaths).toString() + ' Today',
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
            AutoSizeText(stateStat.actuals.hospitalBeds.currentUsageTotal == null
                ? 'N/A'
                : numberFormatter.format(stateStat.actuals.hospitalBeds.currentUsageCovid).toString(),
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
            AutoSizeText(stateStat.actuals.icuBeds.currentUsageCovid == null
                ? 'N/A'
                : numberFormatter.format(stateStat.actuals.icuBeds.currentUsageCovid).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.orange[800]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildInfectionRate(stateStat) {
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
            Text('Infection Rate', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.metrics.infectionRate == null
                ? 'N/A'
                : percentFormatter.format(stateStat.metrics.infectionRate).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.orange[800]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildIcuCapUsed(stateStat) {
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
            Text('ICU Capacity', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.metrics.icuCapacityRatio == null
                ? 'N/A'
                : percentFormatter.format(stateStat.metrics.icuCapacityRatio * 100) + '%',
                style: TextStyle(fontSize: 35.0, color: Colors.orange[800]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildVaccinated(stateStat) {
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
            Text('Vaccinated', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
            AutoSizeText(stateStat.metrics.vaccinationsInitiatedRatio == null
                ? 'N/A'
                : percentFormatter.format(stateStat.metrics.vaccinationsInitiatedRatio * 100) + '%',
                style: TextStyle(fontSize: 35.0, color: Colors.green), maxLines: 1),
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
            LegendColoredBox(color: Colors.redAccent, text: 'Deaths')
          ],
        ),
      ),
    );
  }

  Widget _buildCountiesContainer() {
    return Container(
      height: 330.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0)),
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
        itemCount: usCountiesList == null ? 0 : usCountiesList.length,
        itemBuilder: (BuildContext context, int idx) {
          if (usCountiesList.isEmpty) {
            Text('No data found for counties',
                style: TextStyle(color: Colors.grey));
            return null;
          } else {
            return ListTile(
              title: Text(usCountiesList[idx].county + ' County',
                  style: const TextStyle(fontSize: 25.0)),
              subtitle: Text(numberFormatter.format(usCountiesList[idx].stats.confirmed).toString() + ' cases',
                  style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        SingleCountyView(countyStats: usCountiesList[idx]))
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

  LatLng findStateLatLng(AsyncSnapshot<String> snapshot, String stateName) {
    var stateLocationData = json.decode(snapshot.data);
    List<StateLocation> stateLocationsList = stateLocationData.map<StateLocation>((json) => StateLocation.fromJson(json)).toList();
    var stateLocation = stateLocationsList.where((state) => state.name.contains(USStates.getName(stateName))).toList();
    return LatLng(stateLocation[0].lat, stateLocation[0].lon);
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