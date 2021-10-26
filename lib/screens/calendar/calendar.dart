import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:flutter/material.dart';

String appointment_id = '1';
String doctor_id = '3';
String user_id = 'EVy7S1L1vNYvBblfQN8dfSFhSrB2';
String prescription_id = '1';
bool confirmed = false;
bool reminded = false;
String issue = "Boli mnie brzuszek i nie mogę chodzić.";
DateTime appointment_date = DateTime.now();
DateTime created_date = DateTime.now();

int numberOfAppointments = 1;

class Calendar extends StatelessWidget {
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
            title: Text("Your appointment"),
          ),
          body: StreamBuilder(
              stream: DatabaseService()
                  .appointmentCollection
                  .orderBy('appointment_date')
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
                      }
                      ;

                      return ListView(
                        //itemCount: snapshot.data.docs.length,
                        //separatorBuilder: (BuildContext context, int index) {
                        //  return SizedBox(height: 10);
                        //},
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        children: snapshot.data.docs.map((document) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                                color: MyColors.mountainMeadow.withOpacity(0.7),
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
                                  'Appointment #${numberOfAppointments}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  "Date: ${document['appointment_date']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  "Doctor: ${document['doctor_id']}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
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
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    });
//TUTAJ WKLEJA SIE KOD Z DOŁU
              }),
        ));
  }
}

/*
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              //Navigator.pop(context);
              /*
            DatabaseService().addNewAppointmentToDatabase(
                appointment_id,
                doctor_id,
                user_id,
                prescription_id,
                confirmed,
                reminded,
                issue,
                appointment_date,
                created_date);
                */
            },
            child: Text('Uwaga dodaje dane do bazy danych (odkomentować)!'),
          ),
          */