// United States Screen

import 'package:covid_19_tracker/models/state_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:covid_19_tracker/views/SingleStateView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_states/us_states.dart';

class USViewState extends State<USView> {
  ScrollController _scrollController = ScrollController();
  List statesList = List();
  final numberFormatter = new NumberFormat("#,###", "en_US");

  USViewState() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: FutureBuilder(
        future: ApiResources().getUSResults(),
        builder: (context, snapshot) {
          return snapshot.data != null
              ? _buildStatesResultsList(snapshot.data)
              : _buildProgressIndicator();
      },
    ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('United States'),
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

  Widget _buildStatesResultsList(List<StateStats> statesList) {
    return ListView.separated(
      itemCount: statesList == null ? 0 : statesList.length,
      itemBuilder: (BuildContext context, int idx) {
        if (statesList.isEmpty) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            title: Text(USStates.getName(statesList[idx].state), style: const TextStyle(fontSize: 25)),
            subtitle: Text(numberFormatter.format(statesList[idx].positive).toString() + ' cases',
                style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingleStateView(stateStats: statesList[idx]))
              );
            },
          );
        }
      },
      separatorBuilder: (context, idx) {
        return Divider();
      },
      controller: _scrollController,
    );
  }
}

class USView extends StatefulWidget {
  const USView({Key key}) : super(key : key);

  @override
  USViewState createState() => USViewState();
}
