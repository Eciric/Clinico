import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/appointment/appointment.dart';
import 'package:clinico/screens/home/carousel.dart';
import 'package:clinico/screens/info/info.dart';
import 'package:clinico/screens/profile/profile.dart';
import 'package:clinico/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.steelTeal,
        appBar: AppBar(
          title: Text('Clinico'),
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
        ),
        drawer: new Drawer(
          child: ListView(
            children: [
              new ListTile(
                tileColor: MyColors.darkSkyBlue,
                leading: Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                title: new Text('About Page'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
                trailing: Wrap(
                  children: <Widget>[
                    Icon(Icons.arrow_forward), // icon-1
                  ],
                ),
              ),
              new ListTile(
                tileColor: MyColors.darkSkyBlue,
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: new Text('Settings'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsView()),
                  );
                },
                trailing: Wrap(
                  children: <Widget>[
                    Icon(Icons.arrow_forward), // icon-1
                  ],
                ),
              ),
              new ListTile(
                tileColor: MyColors.darkSkyBlue,
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: new Text('Sign out'),
                onTap: () async {
                  await _auth.signOut();
                },
                trailing: Wrap(
                  children: <Widget>[
                    Icon(Icons.arrow_forward), // icon-1
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: (MediaQuery.of(context).size.width),
          height: (MediaQuery.of(context).size.height),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/main_background.png"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 150.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.jpg'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white)),
                  ),
                  SizedBox(height: 80),
                  MyCarousel(),
                ],
              ),
            ),
          ),
        ));
  }
}
