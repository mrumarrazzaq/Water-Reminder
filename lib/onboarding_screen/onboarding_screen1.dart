// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:water_reminder/colors.dart';
import 'package:water_reminder/constants.dart';

import 'onboarding_screen2.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                cursorColor: blackColor,
                keyboardType: TextInputType.number,
                style: TextStyle(color: blackColor),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Enter your weight',
                  label: Text('Weight', style: TextStyle(color: blackColor)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: darkWaterColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: blackColor, width: 1.0),
                  ),
                  prefixText: '  ',
                  suffixText: 'Kg',
                  suffixStyle: TextStyle(color: blackColor),
                ),
                controller: _weightController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter weight';
                  }
                  return null;
                },
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Material(
              color: darkWaterColor,
              borderRadius: BorderRadius.circular(30.0),
              clipBehavior: Clip.antiAlias,
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (kDebugMode) {
                      print('------------------------------------');
                      print(_weightController.text);
                      print('------------------------------------');
                    }
                    if (_weightController.text == '0' ||
                        int.parse(_weightController.text) < 20 ||
                        int.parse(_weightController.text) > 255) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter weight range from 20-250 kg'),
                        ),
                      );
                    } else {
                      await storage.write(
                          key: 'weight', value: _weightController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Screen2(),
                        ),
                      );
                    }
                  }
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
