import 'package:flutter/material.dart';
import 'package:water_reminder/colors.dart';

import 'setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    Scaffold(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          _currentIndex == 0 ? 'Home' : 'Setting',
          style: TextStyle(color: blackColor),
        ),
        leading: const Text(''),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkWaterColor,
        elevation: 10.0,
        currentIndex: _currentIndex,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: whiteColor,
        unselectedItemColor: greyColor,
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
