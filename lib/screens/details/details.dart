import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details(
      {Key key,
      this.doctor,
      this.dateWithHours,
      this.prescriptionExist,
      this.appointment_id,
      this.done})
      : super(key: key);
  final String doctor;
  final String dateWithHours;
  final bool prescriptionExist;
  final bool done;
  final String appointment_id;
  @override
  Widget build(BuildContext context) {
    var onlyDate = dateWithHours.split(" ");
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
            title: Text("Appointment details"),
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
                    '${dateWithHours}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    'Doctor',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '${doctor}',
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
                  Container(
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    height: 165,
                    decoration: BoxDecoration(
                      color: MyColors.darkSkyBlue.withOpacity(0.5),
                      border: Border.all(
                          width: 3,
                          color: MyColors.darkSkyBlue.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: <Widget>[
                        Visibility(
                          visible: prescriptionExist == true,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Text(
                                'Presciption info',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '${onlyDate[0]}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '${doctor}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              SizedBox(height: 15.0),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        MyColors.mountainMeadow
                                            .withOpacity(0.9)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(90.0)))),
                                child: Text(
                                  'Download as PDF',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: prescriptionExist == false,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Text(
                                'Presciption info',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Wizyta się nie odbyła lub nie posiada żadnej istniejącej recepty!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Visibility(
                    visible: done == false,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              MyColors.mountainMeadow.withOpacity(0.9)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(90.0)))),
                      child: Text(
                        'Cancel appointment',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      onPressed: () {
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        Widget continueButton = TextButton(
                          child: Text("Continue"),
                          onPressed: () {
                            DatabaseService()
                                .cancelAnAppointment(appointment_id);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Alert"),
                          content: Text(
                              "Would you like to cancel your appointment?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40.0),
                ],
              ),
            ),
          ),
        ));
  }
}
