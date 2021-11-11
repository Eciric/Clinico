import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/home/carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService()
            .userCollection
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: MyColors.steelTeal,
              appBar: AppBar(
                title: Text('Clinico'),
                backgroundColor: MyColors.darkSkyBlue,
                elevation: 0.0,
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
                              border:
                                  Border.all(width: 2, color: Colors.white)),
                        ),
                        SizedBox(height: 80),
                        MyCarousel(),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
