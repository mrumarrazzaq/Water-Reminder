import 'package:flutter/material.dart';
import 'package:water_reminder/colors.dart';
import 'package:water_reminder/screens/home_screen.dart';

import 'setting_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;
  final tabs = [
    const HomeScreen(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightWaterColor,
        elevation: 10.0,
        currentIndex: _currentIndex,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: whiteColor,
        unselectedItemColor: blackColor,
        unselectedLabelStyle: const TextStyle(fontFamily: 'SourceSansPro'),
        selectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
