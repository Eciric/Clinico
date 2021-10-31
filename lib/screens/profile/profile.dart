import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:clinico/style/profileButtonDecoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/stringExtension.dart';

class ProfileView extends StatelessWidget {
  final double avatarHeight = 135;
  final double avatarWidth = 135;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("Profile"),
      ),
      body: StreamBuilder(
          stream: DatabaseService()
              .userCollection
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data.docs[0];
              return Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.width *
                                      1 /
                                      10),
                              decoration: BoxDecoration(
                                  color: MyColors.mountainMeadow,
                                  borderRadius: BorderRadius.circular(25)),
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: avatarHeight,
                                    width: avatarWidth,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/doctor.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Doctor / Patient',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${user.get('name').toString().toCapitalized()} ${user.get('surname').toString().toCapitalized()}',
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('${user.get('email')}',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white)),
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text("Pesel",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white)),
                                  Text("${user.get('pesel')}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))
                                ],
                              ),
                              Column(
                                children: [
                                  Text("Phone number",
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white)),
                                  Text("+48${user.get('phoneNumber')}",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 75,
                            thickness: 1,
                            indent: 45,
                            endIndent: 45,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () {},
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('My appointments  ',
                                          style: TextStyle(fontSize: 16)),
                                      Icon(Icons.filter_frames),
                                    ],
                                  )),
                              ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () {},
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Edit my data  ',
                                          style: TextStyle(fontSize: 16)),
                                      Icon(Icons.edit),
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () {},
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Download data  ',
                                          style: TextStyle(fontSize: 16)),
                                      Icon(Icons.download),
                                    ],
                                  )),
                              ElevatedButton(
                                  style: raisedDangerButtonStyle,
                                  onPressed: () {},
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Delete account  ',
                                          style: TextStyle(fontSize: 16)),
                                      Icon(Icons.delete),
                                    ],
                                  )),
                            ],
                          )
                        ],
                      )),
                ],
              );
            } else {
              return Container();
            }
          }),
      //
    );
  }
}
