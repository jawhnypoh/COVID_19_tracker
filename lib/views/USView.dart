// United States Screen

import 'package:covid_19_tracker/models/state_model.dart';
import 'package:covid_19_tracker/views/SingleStateView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:us_states/us_states.dart';

class USViewState extends State<USView> {
  final String _statesURL = 'https://api.covidactnow.org/v2/states.json?apiKey=c3cc1912d5ae41d88782d801c5abf346';
  var dio = Dio();

  ScrollController _scrollController = ScrollController();
  TextEditingController _editingController = TextEditingController();

  Future _future;

  List statesList = List();
  List searchStatesList = List();

  final numberFormatter = new NumberFormat("#,###", "en_US");

  USViewState();

  @override
  void initState() {
    super.initState();
    _future = getUSStatesResults();
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
        future: _future,
        builder: (context, snapshot) {
          return snapshot.data != null
            ? _buildListAndSearchContainer(snapshot.data)
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

  Widget _buildListAndSearchContainer(List statesList) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterStateResults(value);
              },
              controller: _editingController,
              decoration: InputDecoration(
                hintText: 'Search for State',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildStatesResultsList(searchStatesList),
          )
        ],
      ),
    );
  }

  Widget _buildStatesResultsList(List statesList) {
    return ListView.separated(
      itemCount: statesList == null ? 0 : statesList.length,
      itemBuilder: (BuildContext context, int idx) {
        if (statesList.isEmpty) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            title: Text(USStates.getName(statesList[idx].state), style: const TextStyle(fontSize: 25)),
            subtitle: Text(numberFormatter.format(statesList[idx].actuals.cases).toString() + ' cases',
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

  // Filter state results list based on querying value from search
  void filterStateResults(String queryValue) {
    List duplicateStateList = List();
    duplicateStateList.addAll(searchStatesList);

    if (queryValue.isNotEmpty) {
      List statesSearchList = List();

      duplicateStateList.forEach((state) {
        if (USStates.getName(state.state).toLowerCase().contains(queryValue.toLowerCase())) {
          statesSearchList.add(state);
        }
      });

      setState(() {
        searchStatesList.clear();
        searchStatesList.addAll(statesSearchList);
      });
      return;
    } else {
      setState(() {
        searchStatesList.clear();
        searchStatesList.addAll(statesList);
      });
    }
  }

  Future<List<StateStats>> getUSStatesResults() async {
    final List<StateStats> statesResultsList = List();

    try {
      // Get results from disease.sh API for all US states
      final Response stateResponse = await dio.get(_statesURL);
      for(int i = 0; i < stateResponse.data.length; i++) {
        statesResultsList.add(StateStats.fromJson(stateResponse.data[i]));
      }
      statesResultsList.sort((b, a) => a.actuals.cases.compareTo(b.actuals.cases));

      setState(() {
        statesList = statesResultsList;
        searchStatesList.addAll(statesResultsList);
      });
      return statesResultsList;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

class USView extends StatefulWidget {
  const USView({Key key}) : super(key : key);

  @override
  USViewState createState() => USViewState();
}
