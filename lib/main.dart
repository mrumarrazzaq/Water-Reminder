import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/onboarding_screen/onboarding_screen1.dart';
import 'package:water_reminder/screens/dash_board.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isNewUser = false;
  checkUserStatus() async {
    String? value = await storage.read(key: 'uid');
    if (value == null) {
      setState(() {
        isNewUser = false;
      });
    } else {
      setState(() {
        isNewUser = true;
      });
    }
    if (kDebugMode) {
      print('User Status is checking and value is $isNewUser');
    }
  }

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isNewUser ? const DashBoard() : const Screen1(),
    );
  }
}
