import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/doctor/doctor_details.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DoctorAppointments extends StatefulWidget {
  @override
  _DoctorAppointmentsState createState() => _DoctorAppointmentsState();
}

class _DoctorAppointmentsState extends State<DoctorAppointments> {
  @override
  Widget build(BuildContext context) {
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
          title: Text("Appointments"),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
            future: DatabaseService()
                .getUsersDoctorId(FirebaseAuth.instance.currentUser.uid),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final query = snapshot.data[0];
              print(query);
              return StreamBuilder(
                  stream: DatabaseService()
                      .appointmentCollection
                      .where('doctor_id', isEqualTo: query)
                      .orderBy('appointment_date', descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot2) {
                    if (!snapshot2.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      padding: EdgeInsets.only(top: 20),
                      children: snapshot2.data.docs.map((document) {
                        Timestamp temp = document['appointment_date'];
                        DateTime date = temp.toDate();
                        DateFormat displayFormater =
                            DateFormat('yyyy-MM-dd HH:mm:ss');
                        DateTime temp2 = displayFormater.parse(date.toString());
                        DateFormat serverFormater =
                            DateFormat('dd-MM-yyyy HH:mm');
                        String dateDisplay = serverFormater.format(temp2);

                        Timestamp t = document['appointment_date_end'];
                        DateTime d = t.toDate();
                        DateFormat displayFormater2 =
                            DateFormat('yyyy-MM-dd HH:mm:ss');
                        DateTime t2 = displayFormater2.parse(d.toString());
                        DateFormat serverFormater2 = DateFormat('HH:mm');
                        String dateDisplay2 = serverFormater2.format(t2);
                        if (document['done'] == true) return Container();
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 4 / 5,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 40),
                              decoration: BoxDecoration(
                                  color:
                                      MyColors.mountainMeadow.withOpacity(0.7),
                                  border: Border.all(
                                      width: 2,
                                      color: MyColors.mountainMeadow
                                          .withOpacity(0.7)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  Text(
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
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Visibility(
                                    visible: document['is_free'] == true,
                                    child: Text(
                                      "Status: free",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                  Visibility(
                                    visible: document['is_free'] == false,
                                    child: Text(
                                      "Status: taken",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
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
                                              MaterialStateProperty.all(MyColors
                                                  .darkSkyBlue
                                                  .withOpacity(0.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Colors.white,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90.0)))),
                                      child: Text(
                                        'Details',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      ),
                                      onPressed: () async {
                                        var res2 = await DatabaseService()
                                            .doesUserExist(document['user_id']);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DoctorDetails(
                                                status: res2,
                                                start_date: dateDisplay,
                                                end_date: dateDisplay2,
                                                patient: document['user_id'],
                                                appointment_id:
                                                    document['appointment_id'],
                                                issue: document['issue']),
                                          ),
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
      ),
    );
  }
}
