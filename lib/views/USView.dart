// United States Screen

import 'package:covid_19_tracker/views/SingleStateView.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

class USViewState extends State<USView> {
  var dio = Dio();
  ScrollController _scrollController = ScrollController();
  List statesList = List();
  final String _statesURL = "https://disease.sh/v2/states";
  bool isLoading = true;
  final numberFormatter = new NumberFormat("#,###", "en_US");

  USViewState() {}

  @override
  void initState() {
    getUSResults();
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
      body: Container(
        child: _buildStatesResultsList(),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('United States'),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildStatesResultsList() {
    return ListView.separated(
      itemCount: statesList == null ? 0 : statesList.length,
      itemBuilder: (BuildContext context, int idx) {
        if (statesList.isEmpty) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            title: Text(statesList[idx]['state'], style: const TextStyle(fontSize: 25)),
            subtitle: Text(numberFormatter.format(statesList[idx]['cases']).toString() + ' cases',
                style: const TextStyle(fontSize: 20.0, color: Colors.orangeAccent)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SingleStateView(stateName: statesList[idx]['state']))
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

  // Get results from diseash.sh API for all US states
  Future<Response> getUSResults() async {
    final List resultsList = List();

    try {
      final Response response = await dio.get(_statesURL);
      for(int i = 0; i < response.data.length; i++) {
        resultsList.add(response.data[i]);
      }

      resultsList.sort((b, a) => a['cases'].compareTo(b['cases']));

      setState(() {
        statesList = resultsList;
        isLoading = false;
      });
      return response;
    } catch (e) {
      print(e);
    }
  }
}

class USView extends StatefulWidget {
  const USView({Key key}) : super(key : key);

  @override
  USViewState createState() => USViewState();
}
