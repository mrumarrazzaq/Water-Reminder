import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:water_reminder/colors.dart';

import 'package:google_fonts/google_fonts.dart';

import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _weightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            'WEIGHT',
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
