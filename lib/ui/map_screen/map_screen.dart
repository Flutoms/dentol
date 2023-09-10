import 'package:dental_health/ui/permission_screen/location_services.dart';
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
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  final LatLng _initialCameraPosition = const LatLng(
      6.454689620252218, 7.500531016127733);

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
    try {
      List<Location> locations = await locationFromAddress(widget.location);
      if (locations.isNotEmpty) {
        Location firstLocation = locations.first;
        LatLng locationCoordinates = LatLng(
          firstLocation.latitude,
          firstLocation.longitude,
        );
        _mapController.animateCamera(
            CameraUpdate.newLatLng(locationCoordinates));
      }
    } catch (error) {
      print("Geocoding error: $error");
    }
  }

  void _navigateToNearbyScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NearByClinicsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              mapType: MapType.normal,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
                zoom: 14.0,
              ),
            ),
          ),
          Align(
          alignment: AlignmentDirectional.bottomEnd,
            child: Container(
              height: 230,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16),
                  ),
                  color: Colors.white
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: const InputDecoration(hintText: ' Origin'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      controller: _destinationController,
                      decoration: const InputDecoration(hintText: ' Destination'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var directions = await LocationService().getDirections(
                          _originController.text,
                          _destinationController.text,
                        );
                      },
                      child: const Text('Get Directions'),
                    ),
                  ],
                ),
              ),
            ),
          )


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNearbyScreen,
        child: const Icon(Icons.place),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MapScreen(location: 'Your Location Here'),
  ));
}