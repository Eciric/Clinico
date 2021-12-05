import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({
    this.start_date,
    this.end_date,
    this.patient,
    this.appointment_id,
    this.issue,
  });
  final String start_date;
  final String end_date;
  final String patient;
  final String appointment_id;
  final String issue;
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String prescription = "";
  String diagnosis = "";
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/layout_1.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("Details about appointment"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0),
                Text(
                  'Information about appointment',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 25,
                  thickness: 2,
                  indent: 5,
                  endIndent: 5,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${widget.start_date} - ${widget.end_date}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Patient',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                FutureBuilder<dynamic>(
                    future: DatabaseService()
                        .getUsersNameAndSurnameByID(widget.patient),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Text(
                        snapshot.data,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      );
                    }),
                SizedBox(height: 30.0),
                Text(
                  'Issue',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${widget.issue}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Prescription Details',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Type text for prescription',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => prescription = val);
                  },
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Type text for diagnosis',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => diagnosis = val);
                  },
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor: MaterialStateProperty.all(
                          MyColors.darkSkyBlue.withOpacity(0.5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(90.0)))),
                  child: Text(
                    'Add prescription',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  onPressed: () async {
                    var v4 = uuid.v4();
                    DatabaseService()
                        .addPrescription(v4, diagnosis, prescription);
                    DatabaseService().modifyPrescriptionInAppointment(
                        v4, widget.appointment_id);
                  },
                ),
                SizedBox(height: 50.0),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 60)),
                      backgroundColor: MaterialStateProperty.all(
                          MyColors.darkSkyBlue.withOpacity(0.5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(90.0)))),
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  onPressed: () async {
                    DatabaseService().finishAppointment(widget.appointment_id);
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 1), () {
                            Navigator.of(context).pop(true);
                          });
                          return AlertDialog(
                            title: Text(
                              'Appointment done!',
                              textAlign: TextAlign.center,
                            ),
                          );
                        });
                  },
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
