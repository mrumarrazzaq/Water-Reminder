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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _weightController.clear();
                    //Add path here
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
