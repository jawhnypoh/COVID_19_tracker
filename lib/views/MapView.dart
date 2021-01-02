// Map with COVID Testing Sites Screen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewState extends State<MapView> {
  GoogleMapController mapController;

  String stateAbr;

  final LatLng _center = LatLng(37.42796133580664, -122.085749655962);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MapViewState(this.stateAbr);

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Testing Centers in ' + stateAbr),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0
          ),
      )
    );
  }
}

class MapView extends StatefulWidget {
  // Declare stateAbr that has the abbreviation for the state
  final String stateAbr;

  // Require stateAbr in constructor
  MapView({Key key, @required this.stateAbr}) : super(key : key);

  @override
  MapViewState createState() => MapViewState(stateAbr);
}