import 'package:clinico/services/auth.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditUserData extends StatefulWidget {
  @override
  _EditUserDataState createState() => _EditUserDataState();
}

class _EditUserDataState extends State<EditUserData> {
  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String err = '';
  String name = '';
  String surname = '';
  String phoneNumber = '';
  int flag = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        bottom: PreferredSize(
          child: Container(
            color: Colors.white,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(4.0),
        ),
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          "Edit Data",
          style: TextStyle(fontSize: 34, fontStyle: FontStyle.italic),
        ),
      ),
      body: StreamBuilder(
          stream: DatabaseService(uid: '')
              .userCollection
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              var user = snapshot.data.docs[0];
              if (flag == 0) {
                name = user.get('name').toString();
                surname = user.get('surname').toString();
                phoneNumber = user.get('phoneNumber').toString();
                flag = 1;
              }
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          initialValue: '${user.get('name').toString()}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            fillColor: MyColors.steelTeal.withOpacity(0.4),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 15),
                            suffixIcon: Icon(Icons.person,
                                color: Colors.white, size: 25.0),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          initialValue: '${user.get('surname').toString()}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            fillColor: MyColors.steelTeal.withOpacity(0.4),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 15),
                            suffixIcon: Icon(Icons.person,
                                color: Colors.white, size: 25.0),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your surname' : null,
                          onChanged: (val) {
                            setState(() => surname = val);
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          initialValue: '${user.get('phoneNumber').toString()}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            fillColor: MyColors.steelTeal.withOpacity(0.4),
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 20, top: 15),
                            suffixIcon: Icon(Icons.person,
                                color: Colors.white, size: 25.0),
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter your phone number' : null,
                          onChanged: (val) {
                            setState(() => phoneNumber = val);
                          },
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(140, 35)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          onPressed: () async {
                            await DatabaseService(uid: '').modifyUserData(
                                name,
                                surname,
                                user.get('userId').toString(),
                                phoneNumber);

                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.of(context).pop(true);
                                  });
                                  return AlertDialog(
                                    title: Text(
                                      'Zmieniono dane!',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                });
                          },
                          child: Text('Change data'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
