import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String appointment_id = '1';
String doctor_id = '3';
String user_id = 'EVy7S1L1vNYvBblfQN8dfSFhSrB2';
String prescription_id = '1';
bool confirmed = false;
bool reminded = false;
String issue = "Boli mnie brzuszek i nie mogę chodzić.";
DateTime appointment_date = DateTime.now();
DateTime created_date = DateTime.now();

int numberOfAppointments = 0;

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //RESETING VARIABLE
    numberOfAppointments = 0;
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
                          //Titles has numbers from 1 to .... Appointment#1..2...3
                          numberOfAppointments += 1;
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
                          //String current_doctor = doctors.docs.last['name'];
                          //String current_doctor =
                          //Converting date

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
                                      'Appointment #${numberOfAppointments}',
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
                                        onPressed: () async {
                                          Navigator.pop(context);
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
