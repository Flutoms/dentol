
import 'package:flutter/material.dart';

class Collections extends StatelessWidget {
  final String clinicName;
  final String address;

  Collections(this.clinicName, this.address);

  @override
  Widget build(BuildContext context) {
    // CollectionReference clinicCollection =
    // FirebaseFirestore.instance.collection('clinic name');

    Future<void> addClinic() async {
      // return clinicCollection
      //     .doc('VqMeh18dWem3h2kQ3WYS')
      //     .update(
      //   {
      //     'clinic_name': 'Smilecare clinic',
      //     'address': 'Nike Rd Trans Ekulu',
      //   },
      //   //SetOptions(merge: true),
      // )
      //     .then(
      //       (_) => print("'clinic_name' & 'address' merged with existing data!"),
      // )
      //     .catchError((error) => print("Failed to add clinic: $error"));
    }

    return TextButton(
      onPressed:()=> addClinic,
      child: const Text(
        "Add Clinic",
      ),
     );
  }
}
