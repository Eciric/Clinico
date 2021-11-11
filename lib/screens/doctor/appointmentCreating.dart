import 'package:clinico/models/myUser.dart';
import 'package:clinico/screens/details/details.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart';

// ignore: must_be_immutable
class DoctorAppointmentCreating extends StatefulWidget {
  @override
  _DoctorAppointmentCreatingState createState() =>
      _DoctorAppointmentCreatingState();
}

class _DoctorAppointmentCreatingState extends State<DoctorAppointmentCreating> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String hour = "--";
  String minute = "--";

  String hour2 = "--";
  String minute2 = "--";

  DateTime selectedDate = DateTime.now();
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
          title: Text("Doctor appointment creating"),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 4 / 5,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: MyColors.mountainMeadow.withOpacity(0.7),
                border: Border.all(
                    width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      'Pick appointment date',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3 + 20,
                      height: 40,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: MaterialButton(
                        onPressed: () => _selectDate(context),
                        child: Row(children: <Widget>[
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 15),
                          Icon(Icons.calendar_today),
                        ]),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Pick time range',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Row(
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: ButtonWidget(
                            text: "${hour}:${minute}",
                            onClicked: () => _selectTime(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'To',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 40,
                          child: ButtonWidget(
                            text: "${hour2}:${minute2}",
                            onClicked: () => _selectTime2(context),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(250, 50)),
                          backgroundColor: MaterialStateProperty.all(
                              MyColors.darkSkyBlue.withOpacity(0.8)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(90.0)))),
                      child: Text(
                        'Create appointment',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      onPressed: () {
                        String dateWithoutTime =
                            "${selectedDate.toLocal()}".split(' ')[0];
                        String wholeDate =
                            dateWithoutTime + " " + hour + ":" + minute;
                        DateTime dateTimeStartAppointment =
                            DateTime.parse(wholeDate);
                        //print(wholeDate);
                        //print(dateTimeStartAppointment);
                        String wholeDate2 =
                            dateWithoutTime + " " + hour2 + ":" + minute2;
                        DateTime dateTimeEndAppointment =
                            DateTime.parse(wholeDate2);
                        //print(dateTimeEndAppointment);
                        //print("---");
                      },
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 11),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime)
      setState(() {
        if (picked.hour >= 0 && picked.hour <= 9)
          hour = "0" + picked.hour.toString();
        else
          hour = picked.hour.toString();
        if (picked.minute >= 0 && picked.minute <= 9)
          minute = "0" + picked.minute.toString();
        else
          minute = picked.minute.toString();
        selectedTime = picked;
      });
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (picked != null && picked != selectedTime)
      setState(() {
        if (picked.hour >= 0 && picked.hour <= 9)
          hour2 = "0" + picked.hour.toString();
        else
          hour2 = picked.hour.toString();
        if (picked.minute >= 0 && picked.minute <= 9)
          minute2 = "0" + picked.minute.toString();
        else
          minute2 = picked.minute.toString();
        selectedTime = picked;
      });
  }
}

//DODAWANIE DO BAZY DANYCH
//DWÓCH DAT, JEDNEJ JAKO POCZĄTEK, DRUGIEJ JAKO KONIEC WIZYTY
//SPRAWDZANIE CZY WIZYTA KTORA CHCESZ BOOKOWAĆ BĘDZIE PO ZA GRANICAMI
//POCZĄTEK WIZTY + JEJ KONIEC SPRAWDZANY ZA POMOCĄ:
// https://www.kindacode.com/article/flutter-dart-check-if-a-date-is-between-2-dates/
