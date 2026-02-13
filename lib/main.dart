import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/weather_app/weather_app_1.dart';
// import 'package:my_app/whatsapp_login/login_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My New App',
      theme: ThemeData(textTheme: GoogleFonts.fredokaTextTheme()),
      home: const WeatherApp(), // Start app from Login
    );
  }
}
