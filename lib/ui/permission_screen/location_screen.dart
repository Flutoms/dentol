import 'package:dental_health/ui/map_screen/map_screen.dart';
import 'package:flutter/material.dart';

class LocationInputScreen extends StatefulWidget {
  const LocationInputScreen({Key? key}) : super(key: key);

  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  TextEditingController _locationController = TextEditingController();

  void saveLocation() {
    String location = _locationController.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Saved'),
        content: Text('Your current location is: $location'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(location: location),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Input'),
        backgroundColor: const Color(0xFF3e5a81),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40.0),
            TextFormField(
              controller: _locationController,
              cursorColor: const Color(0xFF3e5a81),
              decoration: InputDecoration(
                hintText: 'Enter your current location',
                hintStyle: TextStyle(
                  color: const Color(0xFF3e5a81).withOpacity(0.5),
                  fontSize: 14,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFF90caf8),
                    )),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide(
                      color: Color(0xFF3e5a81),
                    )),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: saveLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF90caf8),
              ),
              child: const Text(
                'Show Location',
                style: TextStyle(
                  color: Color(0xFF3e5a81),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
