import 'package:flutter/material.dart';

import 'package:water_reminder/screens/home_screen.dart';

import 'package:water_reminder/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final TextEditingController _wakeTimeController = TextEditingController();
  final TextEditingController _bedTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateTime _selectedTime = DateTime.now();
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
            'SLEEP CYCLE',
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
