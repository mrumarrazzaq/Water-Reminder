// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:water_reminder/screens/dash_board.dart';
import 'package:water_reminder/colors.dart';
import 'package:water_reminder/constants.dart';

class Screen3 extends StatefulWidget {
  Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final TextEditingController _wakeTimeController = TextEditingController();
  final TextEditingController _bedTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateTime _selectedTime = DateTime.now();

  @override
  void initState() {
    _wakeTimeController.text = '7:00 AM';
    _bedTimeController.text = '10:00 PM';
    super.initState();
  }

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
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                cursorColor: blackColor,
                keyboardType: TextInputType.none,
                style: TextStyle(color: blackColor),
                decoration: InputDecoration(
                  isDense: true,
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: Text('Wake Time', style: TextStyle(color: blackColor)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: darkWaterColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: blackColor, width: 1.0),
                  ),
                  prefixText: '  ',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _getTimeFromUser(isWakeTime: true);
                    },
                    icon: Icon(Icons.access_time, color: lightWaterColor),
                  ),
                  suffixStyle: TextStyle(color: blackColor),
                ),
                controller: _wakeTimeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Select wake time';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                cursorColor: blackColor,
                keyboardType: TextInputType.none,
                style: TextStyle(color: blackColor),
                decoration: InputDecoration(
                  isDense: true,
                  enabled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  label: Text('Bed Time', style: TextStyle(color: blackColor)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: darkWaterColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: blackColor, width: 1.0),
                  ),
                  prefixText: '  ',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _getTimeFromUser(isWakeTime: false);
                    },
                    icon: Icon(Icons.access_time, color: lightWaterColor),
                  ),
                  suffixStyle: TextStyle(color: blackColor),
                ),
                controller: _bedTimeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Select bed time';
                  }
                  return null;
                },
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
                        print(_wakeTimeController.text);
                        print(_bedTimeController.text);
                        print('------------------------------------');
                      }

                      await storage.write(
                          key: 'wakeTime', value: _wakeTimeController.text);
                      await storage.write(
                          key: 'bedTime', value: _bedTimeController.text);
                      await storage.write(key: 'uid', value: 'true');

                      _wakeTimeController.clear();
                      _bedTimeController.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashBoard(),
                        ),
                      );
                    }
                  },
                  height: 45.0,
                  minWidth: double.infinity,
                  color: darkWaterColor,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getTimeFromUser({required bool isWakeTime}) async {
    var pickedTime = await _showTimePicker();
    String formatTime = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isWakeTime == true) {
      setState(() {
        _wakeTimeController.text = formatTime;
      });
    } else if (isWakeTime == false) {
      setState(() {
        _bedTimeController.text = formatTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: _selectedTime.hour,
        minute: _selectedTime.minute,
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
