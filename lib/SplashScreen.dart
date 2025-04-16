import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecture02mushaf/AudioSurahScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AudioSurahScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/alaffasy.png"),
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              "القرآن الكريم بصوت العفاسي",
              textAlign: TextAlign.center,
              style: GoogleFonts.amiriQuran(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Al-Quran Al-Kareem Bi Sawt Al-Affasy",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
