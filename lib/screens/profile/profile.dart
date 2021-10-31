import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final double avatarHeight = 150;
  final double avatarWidth = 150;

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
                              margin: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.width *
                                      1 /
                                      10),
                              decoration: BoxDecoration(
                                  color: MyColors.mountainMeadow,
                                  borderRadius: BorderRadius.circular(25)),
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              height: avatarHeight + 115,
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
                                          fontSize: 17, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      '${user.get('name')} ${user.get('surname')}',
                                      style: TextStyle(
                                          fontSize: 21, color: Colors.white)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('${user.get('email')}',
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white))
                                ],
                              )),
                          Container(
                            child: Text("TEST"),
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

// Stack(children: [
//                 Positioned(
//                   top: 80,
//                   left: 0,
//                   right: 0,
//                   child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 50),
//                       margin: EdgeInsets.symmetric(horizontal: 50),
//                       width: MediaQuery.of(context).size.width * 4 / 5,
//                       height: MediaQuery.of(context).size.width * 1 / 5 +
//                           avatarHeight,
//                       decoration: BoxDecoration(
//                           color: MyColors.mountainMeadow,
//                           borderRadius: BorderRadius.circular(25)),
//                       child: Column(
//                         children: [
//                           SizedBox(height: avatarHeight / 1.45),
//                           Text('Doctor / Patient',
//                               style:
//                                   TextStyle(fontSize: 17, color: Colors.white)),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('${user.get('name')} ${user.get('surname')}',
//                               style:
//                                   TextStyle(fontSize: 21, color: Colors.white)),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text('${user.get('email')}',
//                               style:
//                                   TextStyle(fontSize: 17, color: Colors.white))
//                         ],
//                       )),
//                 ),
//                 Positioned(
//                   top: 25,
//                   left: MediaQuery.of(context).size.width / 2 - avatarWidth / 2,
//                   child: Container(
//                     height: avatarHeight,
//                     width: avatarWidth,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/images/doctor.jpg'),
//                         fit: BoxFit.fill,
//                       ),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                     top: 325,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Column(
//                               children: [
//                                 Text('My id'),
//                                 Text(
//                                     '${user.get('userId').toString().substring(0, 16)}')
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Text('Phone number'),
//                                 Text('${user.get('phoneNumber')}')
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ))
//               ]);