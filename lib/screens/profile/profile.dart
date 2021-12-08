import 'package:clinico/screens/appointment/appointment.dart';
import 'package:clinico/screens/profile/edit_data.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/services/pdfCreator.dart';
import 'package:clinico/style/colors.dart';
import 'package:clinico/style/profileButtonDecoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/stringExtension.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class ProfileView extends StatefulWidget {
  @override
  ProfileViewState createState() => new ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  final double avatarHeight = 135;
  final double avatarWidth = 135;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService databaseService = new DatabaseService();

  //PdfCreator pdfCreator;

  @override
  void initState() {
    super.initState();
   // pdfCreator = new PdfCreator();
  }

  // void deleteUser(var user) async {
  //   Navigator.pop(context);
  //   await _auth.currentUser
  //       .delete()
  //       .then((value) =>
  //           {databaseService.userCollection.doc(user.get('userId')).delete()})
  //       .then((value) => {
  //             Fluttertoast.showToast(
  //                 msg: "User deleted successfully",
  //                 toastLength: Toast.LENGTH_SHORT,
  //                 gravity: ToastGravity.BOTTOM_RIGHT,
  //                 timeInSecForIosWeb: 1,
  //                 backgroundColor: Colors.green,
  //                 textColor: Colors.white,
  //                 fontSize: 16.0),
  //           })
  //       .catchError((error) => {
  //             Fluttertoast.showToast(
  //                 msg: "Failed to delete user",
  //                 toastLength: Toast.LENGTH_SHORT,
  //                 gravity: ToastGravity.BOTTOM_RIGHT,
  //                 timeInSecForIosWeb: 1,
  //                 backgroundColor: Colors.red,
  //                 textColor: Colors.white,
  //                 fontSize: 16.0)
  //           });
  // }

  // void downloadUserData(var user) {
  //   pdfCreator.writeUserDataToPDF(user);
  //   pdfCreator
  //       .saveUserDataToPDF(user)
  //       .then((value) => Fluttertoast.showToast(
  //           msg: "PDF saved successfully",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0))
  //       .catchError((error) => Fluttertoast.showToast(
  //           msg: "Failed to save PDF",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM_RIGHT,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0));
  // }

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
                                  Text(
                                      '${user.get('role').toString().toCapitalized()}',
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Appointments()),
                                    );
                                  },
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditUserData()),
                                    );
                                  },
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
                                  onPressed: () {
                                   // downloadUserData(user);
                                  },
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Download data  ',
                                          style: TextStyle(fontSize: 16)),
                                      Icon(Icons.download_sharp),
                                    ],
                                  )),
                              ElevatedButton(
                                  style: raisedDangerButtonStyle,
                                  onPressed: () {
                                    return showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Deleting account'),
                                        content: const Text(
                                            'Are you sure you want to delete the account?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context, 'Delete'),
                                              //deleteUser(user)
                                            },
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
