// State Historical Data View
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19_tracker/models/state_historical_data_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StateHistoricalDataViewState extends State<StateHistoricalDataView> {
  // Selected date by the user, defaults to current date
  DateTime selectedDate = DateTime.now();

  final numberFormatter = NumberFormat('#,###', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Historical Data for OR'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(bottom: 30.0)),
              buildDatePicker(),
              const Padding(padding: EdgeInsets.only(bottom: 10.0)),
              const Divider(color: Colors.grey, indent: 10.0, endIndent: 10.0),
              const Padding(padding: EdgeInsets.only(bottom: 20.0)),
              buildStateHistoricalData()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDatePicker() {
    return Container(
        child: Column(
//          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: () => selectDate(context), // Refer step 3
              child: Text(
                'Choose a Date',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Colors.greenAccent,
            ),
          ],
        )
    );
  }

  Widget buildStateHistoricalData() {
    return Container(
      child: FutureBuilder<StateHistoricalStats>(
        future: ApiResources().getSingleStateHistoricalResults("or", "20201201"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTotalTestedWidget(snapshot.data),
                  const Padding(padding: EdgeInsets.only(top: 30.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildTotalCases(snapshot.data),
                      buildTotalDeaths(snapshot.data),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildHospitalized(snapshot.data),
                      buildICU(snapshot.data),
                      buildVentilator(snapshot.data),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10.0)),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } return const Center(
            child: Padding(
              padding: EdgeInsets.all(100.0),
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  Widget buildTotalTestedWidget(stateHistoricalStat) {
    return Container(
        child: Center(
            child: Column(
                children: <Widget>[
                  Text('Total Tested', style: TextStyle(fontSize: 15.0, color: Colors.grey[350])),
                  Text(numberFormatter.format(stateHistoricalStat.totalTestResults).toString(), style: TextStyle(fontSize: 60.0, color: Colors.lightBlueAccent)),
                  Text('+' + numberFormatter.format(stateHistoricalStat.totalTestResultsIncrease).toString(),
                      style: TextStyle(fontSize: 30.0, color: Colors.lightBlueAccent))
                ]
            )
        )
    );
  }

  Widget buildTotalCases(stateHistoricalStat) {
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
                  AutoSizeText(numberFormatter.format(stateHistoricalStat.positive).toString(),
                      style: TextStyle(fontSize: 40.0, color: Colors.orangeAccent), maxLines: 1),
                  Text('+' + numberFormatter.format(stateHistoricalStat.positiveIncrease).toString(),
                      style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent))
                ]
            )
        )
    );
  }

  Widget buildTotalDeaths(stateHistoricalStat) {
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
            AutoSizeText(numberFormatter.format(stateHistoricalStat.death).toString(),
                style: TextStyle(fontSize: 40.0, color: Colors.redAccent), maxLines: 1),
            Text('+' + numberFormatter.format(stateHistoricalStat.deathIncrease).toString(),
                style: TextStyle(fontSize: 20.0, color: Colors.redAccent))
          ],
        ),
      ),
    );
  }

  Widget buildHospitalized(stateHistoricalStat) {
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
            AutoSizeText(stateHistoricalStat.hospitalizedCurrently == null
                ? 'N/A'
                : numberFormatter.format(stateHistoricalStat.hospitalizedCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.amber), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget buildICU(stateHistoricalStat) {
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
            AutoSizeText(stateHistoricalStat.inIcuCurrently == null
                ? 'N/A'
                : numberFormatter.format(stateHistoricalStat.inIcuCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.orange[800]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget buildVentilator(stateHistoricalStat) {
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
            AutoSizeText(stateHistoricalStat.onVentilatorCurrently == null
                ? 'N/A'
                : numberFormatter.format(stateHistoricalStat.onVentilatorCurrently).toString(),
                style: TextStyle(fontSize: 35.0, color: Colors.deepOrange[700]), maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(100.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030)
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}

class StateHistoricalDataView extends StatefulWidget {
  StateHistoricalDataView({Key key}) : super(key : key);

  @override
  StateHistoricalDataViewState createState() => StateHistoricalDataViewState();
}