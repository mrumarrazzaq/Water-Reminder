// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:water_reminder/colors.dart';
import 'package:water_reminder/constants.dart';

import 'onboarding_screen3.dart';

class Screen2 extends StatefulWidget {
  Screen2({Key? key}) : super(key: key);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile<int>(
            value: 0,
            title: const Text('Male'),
            groupValue: selectedValue,
            activeColor: darkWaterColor,
            onChanged: (value) {
              setState(() {
                selectedValue = 0;
              });
            },
          ),
          RadioListTile<int>(
            value: 1,
            title: const Text('Female'),
            groupValue: selectedValue,
            activeColor: darkWaterColor,
            onChanged: (value) {
              setState(() {
                selectedValue = 1;
              });
            },
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Material(
              color: darkWaterColor,
              borderRadius: BorderRadius.circular(30.0),
              clipBehavior: Clip.antiAlias,
              child: MaterialButton(
                onPressed: () async {
                  String gender;
                  selectedValue == 0 ? gender = 'Male' : gender = 'Female';
                  if (kDebugMode) {
                    print('------------------------------------');
                    print(gender);
                    print('------------------------------------');
                  }
                  await storage.write(key: 'gender', value: gender);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Screen3(),
                    ),
                  );
                },
                height: 45.0,
                minWidth: double.infinity,
                color: darkWaterColor,
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
