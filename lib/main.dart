import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/appointment_screen.dart';

void main() {
  runApp(const HospitalOnWheelsApp());
}

class HospitalOnWheelsApp extends StatelessWidget {
  const HospitalOnWheelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Imaging on Wheels',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/appointment': (context) => const AppointmentScreen(),
        // Add '/services', '/doctors', etc. here as you expand
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}