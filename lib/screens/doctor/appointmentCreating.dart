import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  String error = "";
  String hour2 = "--";
  var uuid = Uuid();
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
        body: StreamBuilder(
            stream: DatabaseService()
                .userCollection
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder:
                // ignore: missing_return
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var user = snapshot.data.docs[0];

                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: MyColors.mountainMeadow.withOpacity(0.7),
                        border: Border.all(
                            width: 2,
                            color: MyColors.mountainMeadow.withOpacity(0.7)),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                            SizedBox(height: 20.0),
                            Text(
                              error,
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(250, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      MyColors.darkSkyBlue.withOpacity(0.8)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(90.0)))),
                              child: Text(
                                'Create appointment',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              onPressed: () {
                                try {
                                  String dateWithoutTime =
                                      "${selectedDate.toLocal()}".split(' ')[0];
                                  String wholeDate = dateWithoutTime +
                                      " " +
                                      hour +
                                      ":" +
                                      minute;
                                  DateTime dateTimeStartAppointment =
                                      DateTime.parse(wholeDate);
                                  //print(wholeDate);
                                  //print(dateTimeStartAppointment);
                                  String wholeDate2 = dateWithoutTime +
                                      " " +
                                      hour2 +
                                      ":" +
                                      minute2;
                                  DateTime dateTimeEndAppointment =
                                      DateTime.parse(wholeDate2);
                                  if (dateTimeEndAppointment
                                      .isAfter(dateTimeStartAppointment)) {
                                    var uuid_var = uuid.v4();
                                    var status = DatabaseService()
                                        .checkIfDateIsFree(
                                            dateTimeStartAppointment,
                                            dateTimeEndAppointment,
                                            user.get('doctor_id'));
                                    status.then((doc) {
                                      if (doc == true) {
                                        DatabaseService(uid: uuid_var)
                                            .addNewAppointmentToDatabase(
                                                uuid_var,
                                                user.get('doctor_id'),
                                                null,
                                                "",
                                                false,
                                                false,
                                                true,
                                                false,
                                                "",
                                                dateTimeStartAppointment,
                                                dateTimeEndAppointment,
                                                DateTime.now());
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              Future.delayed(
                                                  Duration(seconds: 1), () {
                                                Navigator.of(context).pop(true);
                                              });
                                              return AlertDialog(
                                                title: Text(
                                                  'Dodano wizytę!',
                                                  textAlign: TextAlign.center,
                                                ),
                                              );
                                            });
                                        setState(() {
                                          error = "";
                                        });
                                      } else {
                                        setState(() {
                                          error = "Date is taken!";
                                        });
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      error = "Wrong hours!";
                                    });
                                  }
                                  //if(dateTimeStartAppointment<dateTimeEndAppointment)
                                } on Exception catch (_) {
                                  setState(() {
                                    error = "Wrong input!";
                                  });
                                }

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
                );
              } else {
                return Container();
              }
            }),
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
