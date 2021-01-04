// Map with COVID Testing Sites Screen

import 'dart:convert';

import 'package:covid_19_tracker/models/testing_center_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewState extends State<MapView> {
  GoogleMapController mapController;

  final Map<String, Marker> _markers = {};

  String stateAbr;

  LatLng stateLatLng;

  // Default location to Portland, OR if stateLatLng is null for some reason
  final LatLng _defaultLocation = const LatLng(45.521563, -122.677433);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final List<TestingCenter> testingLocations = await ApiResources().getUSTestingCenters(stateAbr);

    setState(() {
      _markers.clear();
      for (final TestingCenter testingCenter in testingLocations) {
        final marker = Marker(
          markerId: MarkerId(testingCenter.centerName),
          position: LatLng(double.parse(testingCenter.lat), testingCenter.lon),
          infoWindow: InfoWindow(
            title: testingCenter.centerName,
            snippet: testingCenter.address,
            onTap: () {
              // TODO: What to do if user taps on the infoWindow?
            }
          )
        );
        _markers[testingCenter.centerName] = marker;
      }
    });
  }

  MapViewState(this.stateAbr, this.stateLatLng);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Testing Centers in ' + stateAbr),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: stateLatLng ?? _defaultLocation,
            zoom: 7
        ),
        markers: _markers.values.toSet(),
      )
    );
  }
}

class MapView extends StatefulWidget {
  // Declare stateAbr that has the abbreviation for the state
  final String stateAbr;
  final LatLng stateLatLng;

  // Require stateAbr in constructor
  MapView({Key key, @required this.stateAbr, @required this.stateLatLng}) : super(key : key);

  @override
  MapViewState createState() => MapViewState(stateAbr, stateLatLng);
}