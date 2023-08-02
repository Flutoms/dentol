import 'package:dental_health/ui/permission_screen/location_permission_screen.dart';
import 'package:flutter/material.dart';

import '../util/text_styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/dent.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 60),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Dental Clinic Now \nNear You...",
                    style: boldText(color: Colors.white, fontSize: 26),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LocationPermissionScreen()));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 70),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF90caf8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('Get Started',
                          style: semiBoldText(color: const Color(0xff203552))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
