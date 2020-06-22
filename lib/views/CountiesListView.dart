// Counties Screen

import 'package:covid_19_tracker/models/us_county_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountiesListViewState extends State<CountiesListView> {
  List countiesList;
  String stateName;

  CountiesListViewState(this.countiesList, this.stateName);

  @override
  Widget build(BuildContext context) {
    print("countiesListView: " + stateName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(stateName),
      ),
    );
  }
}

class CountiesListView extends StatefulWidget {
  // Declare countiesList that holds list of counties
  final List countiesList;
  final String stateName;

  // Require countiesList in constructor
  CountiesListView({Key key, @required this.countiesList, @required this.stateName}) : super(key : key);

  @override
  CountiesListViewState createState() => CountiesListViewState(countiesList, stateName);
}