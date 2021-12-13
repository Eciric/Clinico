import 'package:clinico/screens/details/details.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/*
String appointment_id = '1';
String doctor_id = '3';
String user_id = 'EVy7S1L1vNYvBblfQN8dfSFhSrB2';
String prescription_id = '1';
bool confirmed = false;
bool reminded = false;
String issue = "Boli mnie brzuszek i nie mogę chodzić.";
DateTime appointment_date = DateTime.now();
DateTime created_date = DateTime.now();
*/
//test
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RESETING VARIABLE

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/layout_triangular.png'),
          fit: BoxFit.fill,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: MyColors.darkSkyBlue,
            elevation: 0.0,
            title: Text("Your appointment"),
          ),
          body: StreamBuilder(
              stream: DatabaseService()
                  .appointmentCollection
                  .where('user_id', isEqualTo: uid)
                  .orderBy('appointment_date', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return StreamBuilder(
                    stream: DatabaseService()
                        .doctorsCollection
                        .orderBy('name')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (!snapshot2.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {}

                      return ListView(
                        padding: EdgeInsets.only(top: 20),
                        children: snapshot.data.docs.map((document) {
                          //final doctors = snapshot2.data;
                          String current_doctor = "a";
                          snapshot2.data.docs.forEach((document2) {
                            if (document2['doctorId'] ==
                                document['doctor_id']) {
                              current_doctor = document2['name'] +
                                  " " +
                                  document2['surname'];
                            }
                          });
                          bool prescriptionExist = false;
                          if (document['prescription_id'] != "") {
                            prescriptionExist = true;
                          }

                          Timestamp temp = document['appointment_date'];
                          DateTime date = temp.toDate();
                          DateFormat displayFormater =
                              DateFormat('yyyy-MM-dd HH:mm:ss');
                          DateTime temp2 =
                              displayFormater.parse(date.toString());
                          DateFormat serverFormater =
                              DateFormat('dd-MM-yyyy HH:mm');
                          String dateDisplay = serverFormater.format(temp2);

                          return Column(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 4 / 5,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 40),
                                decoration: BoxDecoration(
                                    color: MyColors.mountainMeadow
                                        .withOpacity(0.7),
                                    border: Border.all(
                                        width: 2,
                                        color: MyColors.mountainMeadow
                                            .withOpacity(0.7)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    Text(
                                      //snapshot.data.docs.length
                                      '#Appointment#',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Date: ${dateDisplay}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    Text(
                                      "Doctor: ${current_doctor}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(150, 40)),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    MyColors.darkSkyBlue
                                                        .withOpacity(0.5)),
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        BorderRadius.circular(90.0)))),
                                        child: Text(
                                          'Details',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Details(
                                                    doctor: current_doctor,
                                                    dateWithHours: dateDisplay,
                                                    prescriptionExist:
                                                        prescriptionExist,
                                                    prescription_id: document[
                                                        'prescription_id'],
                                                    appointment_id: document[
                                                        'appointment_id'],
                                                    done: document['done'])),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    });
              }),
        ));
  }
}
