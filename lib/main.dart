import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/whatsapp_ui/login_card.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: const Icon(Icons.whatshot_sharp),
        title: const Text("Whatsapp Login", style: TextStyle(fontSize: 23)),
        centerTitle: true,
      ),

      // Calling external UI widget
      body: const LoginCard(),
    );
  }
}
