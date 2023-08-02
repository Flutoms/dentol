
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

import 'nearby_places.dart';

class MapScreen extends StatefulWidget {
  final String location;
  const MapScreen({required this.location, Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LatLng _initialCameraPosition = const LatLng(6.447946688582, 7.500136151162479);

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _updateCameraPosition();
  }

  void _updateCameraPosition() async {
    List<Location> locations = await locationFromAddress(widget.location);
    if (locations.isNotEmpty) {
      Location firstLocation = locations.first;
      LatLng locationCoordinates = LatLng(
        firstLocation.latitude,
        firstLocation.longitude,
      );
      _mapController.animateCamera(CameraUpdate.newLatLng(locationCoordinates));
    }
  }

  void _navigateToNearbyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NearByClinicsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 14.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNearbyScreen,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
