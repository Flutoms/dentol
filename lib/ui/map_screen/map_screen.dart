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
  final LatLng _initialCameraPosition =
  const LatLng(6.447946688582, 7.500136151162479);

  String locationName = "Your Location Name";
  String purpose = "Your Purpose for the Location";

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _updateCameraPosition();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _updateCameraPosition() async {
    List<Location> locations = await locationFromAddress(widget.location);
    if (locations.isNotEmpty) {
      Location firstLocation = locations.first;
      LatLng locationCoordinates = LatLng(
        firstLocation.latitude,
        firstLocation.longitude,
      );

      setState(() {
        locationName = "Unknown Location";
        purpose = "Your Purpose for the Location"; // Set the actual purpose
      });

      _mapController.animateCamera(CameraUpdate.newLatLng(locationCoordinates));
    }
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
        markers: Set<Marker>.of([
          Marker(
            markerId: MarkerId("locationMarker"),
            position: _initialCameraPosition,
            infoWindow: InfoWindow(
              title: locationName,
              snippet: purpose,
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NearByClinicsScreen(),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
