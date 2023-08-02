import 'package:flutter/material.dart';

import 'ui/welcome_screen/welcome_screen.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: "Find a Dental Clinic",
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );

  }
}