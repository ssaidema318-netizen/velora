import 'package:flutter/material.dart';
import 'package:velora/features/bottom_navbar/custom_bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomBageNavbar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
