import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/appointment/appointment.dart';
import 'package:clinico/screens/info/info.dart';
import 'package:clinico/screens/receipt/receiptview.dart';
import 'package:clinico/screens/settings/settings.dart';
import 'package:clinico/screens/visit/doctors.dart';
import 'package:clinico/screens/visit/visitone.dart';
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
                image: AssetImage("assets/images/dashboard_background.png"),
                fit: BoxFit.fill),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: <Widget>[
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorsView()),
                          );
                        },
                        child: Container(
                          height: 115,
                          width: 115,
                          decoration: new BoxDecoration(
                            color: MyColors.warmBlack.withOpacity(0.85),
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Appointments()),
                          );
                        },
                        child: Container(
                          height: 115,
                          width: 115,
                          decoration: new BoxDecoration(
                              color: MyColors.mountainMeadow.withOpacity(0.85),
                              border: Border.all(width: 2, color: Colors.white),
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/plus_icon.png'),
                                fit: BoxFit.fill,
                              ),
                              shape: BoxShape.circle),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Info()),
                          );
                        },
                        child: Container(
                          height: 115,
                          width: 115,
                          decoration: new BoxDecoration(
                              color: MyColors.darkSkyBlue.withOpacity(0.85),
                              border: Border.all(width: 2, color: Colors.white),
                              image: DecorationImage(
                                image: AssetImage('assets/images/location.png'),
                              ),
                              shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
