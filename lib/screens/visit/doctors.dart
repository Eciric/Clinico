import 'package:clinico/screens/visit/categoryDoctors.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorsView extends StatefulWidget {
  @override
  _DoctorsViewState createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {

  CollectionReference doctorsCollection = DatabaseService().doctorsCollection;
  List<Doctor> doctorss = [];
  bool state= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("1/4 Pick a Doctor from list"),
        actions: [
          TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(MyColors.mountainMeadow),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDoctors(doctors: doctorss),
                    ));
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
      floatingActionButton: null,
      body: StreamBuilder(
        stream: DatabaseService().doctorsCollection.orderBy('name').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return ListView(
            children: snapshot.data.docs.map((document) {
              doctorss.add(Doctor(name: document['name'],surname: document['surname'],phone: document['phoneNumber'],doctorId: document['doctorId'], state: true,specId: document['specid']));
              return Doctor(name: document['name'],surname: document['surname'],phone: document['phoneNumber'],doctorId: document['doctorId'], state: true,doctor: doctorss,specId: document['specid'],);
            }).toList(),
          );
        },
      ),
    );
  }
}


class Doctor extends StatefulWidget {
   final String name;
   final String surname;
   final String phone;
   final String doctorId;
   final List<dynamic> specId;
   List<Doctor> doctor;
   bool state;

   Doctor({this.name,this.surname,this.phone,this.doctorId,this.state,this.doctor,this.specId});
 
   @override
   _DoctorState createState() => _DoctorState();
 }
 
 class _DoctorState extends State<Doctor> {
   bool selected = true;
   @override
   Widget build(BuildContext context) {
         return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30.0,
                        ),
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/doctor.jpg'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Surname: ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Text(
                                  widget.surname,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Text(
                              "Phone Number: " + widget.phone,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Checkbox(
                          activeColor: MyColors.mountainMeadow,
                          value: widget.state ?? true,
                          onChanged: (bool val){
                          for(int i=0;i<widget.doctor.length;i++){
                            if(widget.doctor.elementAt(i).doctorId == widget.doctorId)
                            {
                              setState(() {widget.doctor.elementAt(i).state = val;});
                            }
                          }
                          setState(() { widget.state = val;});
                        },),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              );
   }
 }
