import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/admin/adminView.dart';
import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/doctor/doctor_lobby.dart';
import 'package:clinico/screens/home/homePage.dart';
import 'package:clinico/screens/home/signOutMock.dart';
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
  int _currentIndex = 1;

  List _screens = [
    SignOutMock(),
    HomePage(),
    SettingsView(),
  ];

  List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      label: "Sign out",
      icon: Icon(Icons.logout),
    ),
    BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: "Settings",
      icon: Icon(Icons.settings),
    ),
  ];

  @override
  void initState() {
    super.initState();
    DatabaseService()
        .userCollection
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .first
        .then((user) => {
              if (user.docs.first.get("role") == "doctor")
                {
                  setState(() {
                    _navItems.add(
                      BottomNavigationBarItem(
                        label: "Doctor panel",
                        icon: Icon(Icons.list_alt),
                      ),
                    );
                    _screens.add(DoctorLobby());
                  }),
                },
              if(user.docs.first.get('isAdmin') == true)
              {
                setState(() {
                    _navItems.add(
                      BottomNavigationBarItem(
                        label: "Admin panel",
                        icon: Icon(Icons.admin_panel_settings),
                      ),
                    );
                    _screens.add(AdminPanel());
                  }),
              }
            });
  }

  void _updateIndex(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
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
        items: List.of(_navItems),
      ),
    );
  }
}
