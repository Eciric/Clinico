import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final double avatarHeight = 150;
  final double avatarWidth = 150;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("Profile"),
      ),
      body: Stack(children: [
        Positioned(
          top: 80,
          left: 0,
          right: 0,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              margin: EdgeInsets.symmetric(horizontal: 50),
              width: MediaQuery.of(context).size.width * 4 / 5,
              height: MediaQuery.of(context).size.width * 1 / 5 + avatarHeight,
              decoration: BoxDecoration(
                  color: MyColors.mountainMeadow,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  SizedBox(height: avatarHeight / 1.45),
                  Text('Doctor / Patient',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Ricardo Milos',
                      style: TextStyle(fontSize: 35, color: Colors.white)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Email@email.com',
                      style: TextStyle(fontSize: 20, color: Colors.white))
                ],
              )),
        ),
        Positioned(
          top: 25,
          left: MediaQuery.of(context).size.width / 2 - avatarWidth / 2,
          child: Container(
            height: avatarHeight,
            width: avatarWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/doctor.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
        )
      ]),
    );
  }
}
