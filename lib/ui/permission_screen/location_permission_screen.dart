import 'package:dental_health/ui/components/confirm_dailog.dart';
import 'package:dental_health/ui/map_screen/map_screen.dart';
import 'package:dental_health/ui/util/colors.dart';
import 'package:dental_health/ui/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationPermissionDeniedDialog();
        return Future.error('Location permissions are denied');
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MapScreen(location: ''),
        ),
      );
    }
  }

  void _showLocationPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        titleText: 'Location Permission Denied',
        warningText: 'Please enable location permission in device '
            'settings inorder to use this feature.',
        okText: 'Open Settings',
        onTap: () async {
          await Geolocator.openAppSettings();
          await Geolocator.openLocationSettings();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/images/map.json',
                  height: 90, fit: BoxFit.contain, key: const ValueKey(0)),
              const SizedBox(height: 40),
              Text('Dental wants to access your Location',
                  style: boldText(fontSize: 16)),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    'Enabling your Location services '
                    'ensures you see clinics around you at all times ',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: regularText()),
              ),
              const SizedBox(height: 100),
              InkWell(
                onTap: () => _requestLocationPermission(),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Allow location to continue',
                      style: regularText(
                          fontSize: 16, color: const Color(0xFF90caf8))),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
