import 'package:flutter/material.dart';

import 'screens/customer/splash_screen.dart';

void main() {
  runApp(const LetaGasApp());
}

class LetaGasApp extends StatelessWidget {
  const LetaGasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LetaGas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
