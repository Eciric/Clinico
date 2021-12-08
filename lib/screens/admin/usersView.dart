import 'package:clinico/models/myUser.dart';
import 'package:clinico/screens/admin/takespecialization.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersView extends StatefulWidget {
  @override
  _UsersViewState createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: StreamBuilder(
        stream: DatabaseService().userCollection.orderBy('email').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
              width: MediaQuery.of(context).size.width * 9 / 10,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: MyColors.mountainMeadow.withOpacity(0.80),
                  border: Border.all(
                      width: 2,
                      color: MyColors.mountainMeadow.withOpacity(0.80)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data.docs.map((document) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            document['email'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Spacer(),
                          _buildDoctorPermisions(
                              document['role'],
                              document['userId'],
                              document['phoneNumber'],
                              document['surname'],
                              document['name']),
                          SizedBox(
                            width: 10,
                          ),
                          _buildAdminPermisions(document['isAdmin'],
                              document['email'], user.uid, document['userId']),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }).toList(),
              ));
        },
      ),
    );
  }

  Widget _buildDoctorPermisions(String role, String userid, String phonenumber,
          String surname, String name) =>
      ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(20, 20)),
            backgroundColor: MaterialStateProperty.all(
                MyColors.darkSkyBlue.withOpacity(0.7)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(90.0)))),
        child: role == 'user'
            ? Icon(
                Icons.close,
                color: Colors.red,
              )
            : Icon(
                Icons.check,
                color: Colors.greenAccent,
              ),
        onPressed: () {
          if (role == 'doctor') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Do you want to remove this doctor ?"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () async {
                            await deleteDoctor(userid, role);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Remove Doctor",
                            style: TextStyle(color: Colors.black),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  );
                });
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TakeCategory(
                  userid: userid,
                  role: role,
                  phonenumber: phonenumber,
                  surname: surname,
                  name: name,
                ),
              ),
            );
          }
        },
      );

  Widget _buildAdminPermisions(
          bool role, String email, String currentuser, String userid) =>
      ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(20, 20)),
            backgroundColor: MaterialStateProperty.all(
                MyColors.darkSkyBlue.withOpacity(0.7)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(90.0)))),
        child: role == false
            ? Icon(
                Icons.close,
                color: Colors.red,
              )
            : Icon(
                Icons.check,
                color: Colors.greenAccent,
              ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you want to change admin permission of user " +
                    email +
                    "?"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      if (userid == currentuser) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    "You cant change your own perrmisions !!!"),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: Colors.black),
                                      ))
                                ],
                              );
                            });
                      } else {
                        changeAdminPerrmision(userid, !role);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Change Permissions",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );

  changeAdminPerrmision(String userid, bool isadmin) async {
    await DatabaseService(uid: userid).updateAdminPermissions(isadmin);
  }

  deleteDoctor(String doctorid, String role) async {
    await DatabaseService().doctorsCollection.doc(doctorid).delete();
    await DatabaseService(uid: doctorid).updateDoctorPermissions(
        role == 'doctor' ? 'user' : 'doctor', doctorid);
  }
}
