import 'package:clinico/screens/visit/visitone.dart';
import 'package:clinico/screens/visit/widget/pickdate.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
import 'categoryDoctors.dart';
import 'doctors.dart';

class PickDate extends StatefulWidget {
  List<Doctor> doctors;
  List<Category> categories;

  PickDate({this.doctors, this.categories});
  @override
  _PickDateState createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  DateTimeRange dataRange;
  DateTimeRange dataRangeifnotcheck = DateTimeRange(
      start: DateTime.now(), end: DateTime(DateTime.now().year + 5));

  String getFrom() {
    if (dataRange == null) {
      return '${dataRangeifnotcheck.start.day}/${dataRangeifnotcheck.start.month}/${dataRangeifnotcheck.start.year}';
    } else {
      return '${dataRange.start.day}/${dataRange.start.month}/${dataRange.start.year}';
    }
  }

  String getUntil() {
    if (dataRange == null) {
      return '${dataRangeifnotcheck.end.day}/${dataRangeifnotcheck.end.month}/${dataRangeifnotcheck.end.year}';
    } else {
      return '${dataRange.end.day}/${dataRange.end.month}/${dataRange.end.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/2lines_background.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("3/4 Date pick"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisitOne(
                              doctors: widget.doctors,
                              categories: widget.categories,
                              time: dataRange ?? dataRangeifnotcheck)));
                },
                child: Text(
                  'Go Next',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 5,
              right: MediaQuery.of(context).size.width / 5),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Choose date range",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.white,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                "From",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Divider(
                color: Colors.white,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                text: getFrom(),
                onClicked: () => pickDateRange(context),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.white,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              Text(
                "To",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Divider(
                color: Colors.white,
                height: 25,
                thickness: 2,
                indent: 5,
                endIndent: 5,
              ),
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                text: getUntil(),
                onClicked: () => pickDateRange(context),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dataRange ?? initialDateRange);
    if (newDateRange == null) return;
    setState(() {
      dataRange = newDateRange;
    });
  }
}

/*
//DODAWANIE DO BAZY DANYCH
//DWÓCH DAT, JEDNEJ JAKO POCZĄTEK, DRUGIEJ JAKO KONIEC WIZYTY
//SPRAWDZANIE CZY WIZYTA KTORA CHCESZ BOOKOWAĆ BĘDZIE PO ZA GRANICAMI
//POCZĄTEK WIZTY + JEJ KONIEC SPRAWDZANY ZA POMOCĄ:
// https://www.kindacode.com/article/flutter-dart-check-if-a-date-is-between-2-dates/
import 'package:clinico/models/myUser.dart';
import 'package:clinico/screens/details/details.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clinico/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:intl/date_symbol_data_local.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class DoctorAppointmentCreating extends StatelessWidget {
  DateTimeRange dataRange;
  DateTimeRange dataRangeifnotcheck = DateTimeRange(
      start: DateTime.now(), end: DateTime(DateTime.now().year + 5));

  String getFrom() {
    if (dataRange == null) {
      return '${dataRangeifnotcheck.start.day}/${dataRangeifnotcheck.start.month}/${dataRangeifnotcheck.start.year}';
    } else {
      return '${dataRange.start.day}/${dataRange.start.month}/${dataRange.start.year}';
    }
  }

  String getUntil() {
    if (dataRange == null) {
      return '${dataRangeifnotcheck.end.day}/${dataRangeifnotcheck.end.month}/${dataRangeifnotcheck.end.year}';
    } else {
      return '${dataRange.end.day}/${dataRange.end.month}/${dataRange.end.year}';
    }
  }
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
          title: Text("Doctor appointment creating"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  'You can reach us at',
                  style: TextStyle(
                    fontSize: 32,
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
                  'Contact',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '(+48) 543-333-222',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'clinico@med.pl',
                  style: TextStyle(
                    fontSize: 26,
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.0),
                Text(
                  'Adres',
                  style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 24 * 3)));
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dataRange ?? initialDateRange);
    if (newDateRange == null) return;
    setState(() {
      dataRange = newDateRange;
    });
  }
}

*/