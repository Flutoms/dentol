import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
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
              onPressed: findNearbyClinics,
              child: Text('Find Nearby Clinics'),
            ),
          ],
        ),
      ),
    );
  }

  void findNearbyClinics() async {

    final Map<String, dynamic> results = await getDirections();

    print(results);
  }

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeId = json['candidates'][0]['place_id'] as String;

    return placeId;
  }

  Future<Map<String, dynamic>> getNearbyClinics(String input) async {
    final placeId = await getPlaceId(input);

    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    return results;
  }

  Future<Map<String, dynamic>> getDirections() async {
    final String origin = '$latitude,$longitude';
    const String destination = 'FGCJ+3M8, Thinkers Corner 400103, En=ugu';

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    return results;
  }
}
