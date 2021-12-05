import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/doctor/doctor_appointment.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorLobby extends StatefulWidget {
  @override
  _DoctorLobbyState createState() => _DoctorLobbyState();
}

class _DoctorLobbyState extends State<DoctorLobby> {
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
          title: Text("What do you want to do?"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(300, 100)),
                    backgroundColor: MaterialStateProperty.all(
                        MyColors.darkSkyBlue.withOpacity(0.7)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(90.0)))),
                child: Text(
                  'Create appointment',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorAppointmentCreating(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(300, 100)),
                    backgroundColor: MaterialStateProperty.all(
                        MyColors.darkSkyBlue.withOpacity(0.7)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(90.0)))),
                child: Text(
                  'Your appoinments',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorAppointments(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
