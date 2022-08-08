import 'package:flutter/material.dart';

import 'package:water_reminder/colors.dart';

import 'package:google_fonts/google_fonts.dart';

import 'screen3.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        bottom: PreferredSize(
          preferredSize: const Size(200, 100),
          child: Text(
            'GENDER',
            style: GoogleFonts.kanit(
              textStyle: TextStyle(
                  color: darkWaterColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                  letterSpacing: 2.0),
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
