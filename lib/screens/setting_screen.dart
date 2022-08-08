import 'package:flutter/material.dart';
import 'package:water_reminder/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
    );
  }
}
