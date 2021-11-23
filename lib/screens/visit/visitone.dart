import 'package:clinico/screens/appointment/appointment.dart';
import 'package:clinico/screens/home/home.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'categoryDoctors.dart';
import 'doctors.dart';

class VisitOne extends StatefulWidget {
  List<Doctor> doctors;
  List<Category> categories;
  DateTimeRange time;

  VisitOne({this.doctors, this.categories, this.time});

  @override
  _VisitOneState createState() => _VisitOneState();
}

class _VisitOneState extends State<VisitOne> {
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("Available appointments"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                child: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        floatingActionButton: null,
        body: StreamBuilder(
          stream: DatabaseService()
              .appointmentCollection
              .where('is_free', isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              padding: EdgeInsets.only(top: 20),
              children: snapshot.data.docs.map((document) {
                Timestamp temp = document['appointment_date'];
                DateTime dateofvisit = temp.toDate();
                for (int i = 0; i < widget.doctors.length; i++) {
                  if (document['doctor_id'] ==
                          widget.doctors.elementAt(i).doctorId &&
                      widget.doctors.elementAt(i).state == true) {
                    for (int k = 0; k < widget.categories.length; k++) {
                      if (widget.doctors.elementAt(i).specId.contains(
                              widget.categories.elementAt(k).specid) &&
                          widget.categories.elementAt(k).state == true) {
                        if (widget.time.start.isBefore(dateofvisit) &&
                            widget.time.end.isAfter(dateofvisit) &&
                            DateTime.now().isBefore(dateofvisit))
                          return Appointemnt(
                            doctorid: document['doctor_id'],
                            doctorname: widget.doctors.elementAt(i).name,
                            doctorsurname: widget.doctors.elementAt(i).surname,
                            time: document['appointment_date'].toDate(),
                            appointmentid: document['appointment_id'],
                          );
                      }
                    }
                  }
                }
                return SizedBox(
                  height: 0,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class Appointemnt extends StatefulWidget {
  final String doctorid;
  final String doctorname;
  final String doctorsurname;
  final DateTime time;
  final String appointmentid;

  Appointemnt(
      {this.doctorid,
      this.doctorname,
      this.doctorsurname,
      this.time,
      this.appointmentid});

  @override
  _AppointemntState createState() => _AppointemntState();
}

class _AppointemntState extends State<Appointemnt> {
  bool selected = true;
  String month_name = "";
  String hour = "";
  String minute = "";
  @override
  Widget build(BuildContext context) {
    if (widget.time.month == 1)
      month_name = "January";
    else if (widget.time.month == 2)
      month_name = "February";
    else if (widget.time.month == 3)
      month_name = "March";
    else if (widget.time.month == 4)
      month_name = "April";
    else if (widget.time.month == 5)
      month_name = "May";
    else if (widget.time.month == 6)
      month_name = "June";
    else if (widget.time.month == 7)
      month_name = "July";
    else if (widget.time.month == 8)
      month_name = "August";
    else if (widget.time.month == 9)
      month_name = "September";
    else if (widget.time.month == 10)
      month_name = "October";
    else if (widget.time.month == 11)
      month_name = "November";
    else if (widget.time.month == 12) month_name = "December";
    if (widget.time.hour >= 0 && widget.time.hour <= 9)
      hour = "0" + widget.time.hour.toString();
    else
      hour = widget.time.hour.toString();
    if (widget.time.minute >= 0 && widget.time.minute <= 9)
      minute = "0" + widget.time.minute.toString();
    else
      minute = widget.time.minute.toString();
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 4 / 5,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
                color: MyColors.mountainMeadow.withOpacity(0.7),
                border: Border.all(
                    width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  'Doctor: ${widget.doctorname} ${widget.doctorsurname}',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Day: ${widget.time.day}  ${month_name}  ${widget.time.year}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Time: ${hour}:${minute}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(250, 50)),
                      backgroundColor: MaterialStateProperty.all(
                          MyColors.darkSkyBlue.withOpacity(0.5)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(90.0)))),
                  child: Text(
                    'Book it',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () async {
                    DatabaseService()
                        .makeAnAppointment(uid, widget.appointmentid);
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
      //KOD
    );
  }
}
