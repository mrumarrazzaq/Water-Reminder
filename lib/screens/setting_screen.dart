import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/colors.dart';
import 'package:water_reminder/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _wakeTimeController = TextEditingController();
  final TextEditingController _bedTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DateTime _selectedTime = DateTime.now();
  int selectedGenderValue = 0;
  String previousWeightValue = '';
  int previousGenderValue = 0;
  String previousWakeTimeValue = '';
  String previousBedTimeValue = '';
  bool isUserChangeData = false;
  readUserData() async {
    if (kDebugMode) {
      print('Fetching user data');
    }
    String? weight = await storage.read(key: 'weight');
    String? gender = await storage.read(key: 'gender');
    String? wakeTime = await storage.read(key: 'wakeTime');
    String? bedTime = await storage.read(key: 'bedTime');
    setState(() {
      _weightController.text = weight!;
      previousWeightValue = weight;
      if (gender == 'Male') {
        selectedGenderValue = 0;
        previousGenderValue = 0;
      } else {
        selectedGenderValue = 1;
        previousGenderValue = 1;
      }
      _wakeTimeController.text = wakeTime!;
      previousWakeTimeValue = wakeTime;
      _bedTimeController.text = bedTime!;
      previousBedTimeValue = bedTime;
    });
  }

  @override
  void initState() {
    readUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          'Setting',
          style: TextStyle(color: blackColor),
        ),
        leading: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 2.0,
              margin: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 30.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'WEIGHT',
                      style: TextStyle(color: lightWaterColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                        label:
                            Text('Weight', style: TextStyle(color: blackColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: lightWaterColor, width: 1.5),
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
                ],
              ),
            ),
            Card(
              elevation: 2.0,
              margin: margin,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'GENDER',
                      style: TextStyle(color: lightWaterColor),
                    ),
                  ),
                  RadioListTile<int>(
                    value: 0,
                    title: const Text('Male'),
                    groupValue: selectedGenderValue,
                    activeColor: darkWaterColor,
                    onChanged: (value) {
                      setState(() {
                        selectedGenderValue = 0;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    value: 1,
                    title: const Text('Female'),
                    groupValue: selectedGenderValue,
                    activeColor: darkWaterColor,
                    onChanged: (value) {
                      setState(() {
                        selectedGenderValue = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            Card(
              elevation: 2.0,
              margin: margin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'SLEEP CYCLE',
                      style: TextStyle(color: lightWaterColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                        label: Text('Wake Time',
                            style: TextStyle(color: blackColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: lightWaterColor, width: 1.5),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                        label: Text('Bed Time',
                            style: TextStyle(color: blackColor)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: lightWaterColor, width: 1.5),
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
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Material(
                color: lightWaterColor,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () async {
                    if (_weightController.text != previousWeightValue) {
                      await storage.write(
                          key: 'weight', value: _weightController.text);
                      isUserChangeData = true;
                    }
                    if (selectedGenderValue != previousGenderValue) {
                      String gender = '';
                      selectedGenderValue == 0 ? gender = 'Male' : 'Female';
                      await storage.write(key: 'gender', value: gender);
                      isUserChangeData = true;
                    }
                    if (_wakeTimeController.text != previousWakeTimeValue) {
                      await storage.write(
                          key: 'wakeTime', value: _wakeTimeController.text);
                      isUserChangeData = true;
                    }
                    if (_bedTimeController.text != previousBedTimeValue) {
                      await storage.write(
                          key: 'bedTime', value: _bedTimeController.text);
                      isUserChangeData = true;
                    }
                    print('----------------------------');
                    print(isUserChangeData);
                    if (isUserChangeData) {
                      await Fluttertoast.showToast(
                        msg: 'Changes Save Successfully', // message
                        toastLength: Toast.LENGTH_SHORT, // length
                        gravity: ToastGravity.BOTTOM, // location
                        backgroundColor: Colors.green,
                        timeInSecForIosWeb: 1,
                      );
                    }
                  },
                  color: lightWaterColor,
                  minWidth: double.infinity,
                  height: 50.0,
                  child: Text(
                    'Save',
                    style: TextStyle(color: whiteColor),
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
