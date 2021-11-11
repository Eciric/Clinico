import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/home/homePage.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/screens/settings/settings.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List _screens = [
    HomePage(),
    About(),
    SettingsView(),
  ];

  List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: "About",
      icon: Icon(Icons.info_outline),
    ),
    BottomNavigationBarItem(
      label: "Settings",
      icon: Icon(Icons.settings),
    ),
    BottomNavigationBarItem(
      label: "Sign out",
      icon: Icon(Icons.logout),
    ),
  ];

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 3) {
        AuthService().signOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _updateIndex,
        backgroundColor: MyColors.warmBlack,
        unselectedItemColor: Colors.white,
        selectedItemColor: MyColors.mountainMeadow,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: _navItems,
      ),
    );
  }
}
