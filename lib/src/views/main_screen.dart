import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moduluenergy/custom_icons_icons.dart';
import 'package:moduluenergy/src/views/devices/devices_screen.dart';
import 'package:moduluenergy/src/views/production/production_screen.dart';

import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // index of the currently selected tab

  final tabs = [
    // list of widgets to be displayed when a tab is selected
    HomeScreen(),
    ProductionScreen(),
    DevicesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      // display the widget that corresponds to the currently selected tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.production),
            label: 'Production',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi),
            label: 'Devices',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index; // update the currently selected tab index
          });
        },
      ),
    );
  }
}
