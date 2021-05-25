// Map with COVID Testing Sites Screen

import 'package:covid_19_tracker/models/vaccine_locations_model.dart';
import 'package:covid_19_tracker/utilities/api_resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewState extends State<MapView> {
  GoogleMapController mapController;
  Set<Marker> markerSet = Set();

  final Map<String, Marker> _markers = {};
  String stateAbr;
  LatLng stateLatLng;

  // Default location to Portland, OR if stateLatLng is null for some reason
  final LatLng _defaultLocation = const LatLng(45.521563, -122.677433);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final List<VaccineLocation> vaccineLocations = await ApiResources().getUSVaccineLocations(stateAbr);

    setState(() {
      _markers.clear();
      for (final VaccineLocation vaccineLocation in vaccineLocations) {
        final marker = Marker(
          markerId: MarkerId(vaccineLocation.properties.id.toString()),
          position: LatLng(
              vaccineLocation.geometry.coordinates[1],
              vaccineLocation.geometry.coordinates[0]),
          infoWindow: InfoWindow(
            title: vaccineLocation.properties.providerBrandName,
            snippet: vaccineLocation.properties.address,
            onTap: () {
              // TODO: What to do if user taps on the infoWindow?
              print('onTap() called');
            }
          )
        );
        _markers[vaccineLocation.properties.providerBrandName] = marker;
        markerSet.add(marker);
      }
    });
  }

  MapViewState(this.stateAbr, this.stateLatLng);

  @override
  Widget build(BuildContext context) {
    print('Markers: ' + _markers.values.toString());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vaccine Locations in ' + stateAbr),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
            target: stateLatLng ?? _defaultLocation,
            zoom: 7
        ),
        markers: markerSet,
      ),
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