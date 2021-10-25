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
int appointment_date = DateTime.now().millisecondsSinceEpoch;
int created_date = DateTime.now().millisecondsSinceEpoch;

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("Your appointment"),
      ),
      /*
      body: Column(
        children: <Widget>[
              
                       ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(Size(300, 60)),
                              backgroundColor: MaterialStateProperty.all(
                                  MyColors.darkSkyBlue.withOpacity(0.5)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius:
                                          BorderRadius.circular(90.0)))),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error = 'Wrong data';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                          
      )
      */

      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            //Navigator.pop(context);

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
          },
          child: Text('Uwaga dodaje dane do bazy danych!'),
        ),
      ),
    );
  }
}
