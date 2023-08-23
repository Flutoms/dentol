import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceGeometry {
  final PlaceLocation location;

  PlaceGeometry({
    required this.location,
  });

  factory PlaceGeometry.fromJson(Map<String, dynamic> json) {
    return PlaceGeometry(
      location: PlaceLocation.fromJson(json['location']),
    );
  }
}

class PlaceLocation {
  final double lat;
  final double lng;

  PlaceLocation({
    required this.lat,
    required this.lng,
  });

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Place {
  final String placeId;
  final String name;
  final String vicinity;
  final PlaceGeometry geometry;

  Place({
    required this.placeId,
    required this.name,
    required this.vicinity,
    required this.geometry,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      name: json['name'],
      vicinity: json['vicinity'],
      geometry: PlaceGeometry.fromJson(json['geometry']),
    );
  }
}

class PlaceResponse {
  final List<Place> results;

  PlaceResponse({
    required this.results,
  });

  factory PlaceResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['results'];
    return PlaceResponse(
      results: results.map((place) => Place.fromJson(place)).toList(),
    );
  }

  static List<Place> parseResults(List<dynamic> results) {
    return results.map((place) => Place.fromJson(place)).toList();
  }
}

class NearByClinicsScreen extends StatefulWidget {
  const NearByClinicsScreen({Key? key}) : super(key: key);

  @override
  State<NearByClinicsScreen> createState() => _NearByClinicsScreenState();
}

class _NearByClinicsScreenState extends State<NearByClinicsScreen> {
  String apiKey = 'AIzaSyDOu_4ceUuT4s9s2xf1UjBATg3fC2DwJsI';
  String radius = '30';
  double latitude = 6.469253;
  double longitude = 7.5283;
  List<Marker> markers = <Marker>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby clinic'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                searchNearby(latitude, longitude);
              },
               child: const Text('Find Nearby Clinics'),
            ),
            const SizedBox(height: 20),
            Container(
              height: 800,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 14.0,
                ),
                markers: Set<Marker>.of(markers),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> searchNearby(double latitude, double longitude) async {
    setState(() {
      markers.clear();
    });

    const baseUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    final url =
        '$baseUrl?key=$apiKey&location=$latitude,'
        '$longitude&radius=$radius&keyword=clinic';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby clinics');
    }
  }

  void _handleResponse(Map<String, dynamic> data) {
    final places = PlaceResponse.parseResults(data['results']);

    setState(() {
      for (int i = 0; i < places.length; i++) {
        markers.add(
          Marker(
            markerId: MarkerId(places[i].placeId),
            position: LatLng(
              places[i].geometry.location.lat,
              places[i].geometry.location.lng,
            ),
            infoWindow: InfoWindow(
              title: places[i].name,
              snippet: places[i].vicinity,
            ),
            onTap: () {
            },
          ),
        );
      }
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: NearByClinicsScreen(),
  ));
}
