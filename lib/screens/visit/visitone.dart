import 'dart:async';

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

  VisitOne({this.doctors,this.categories,this.time});

  @override
  _VisitOneState createState() => _VisitOneState();
}

class _VisitOneState extends State<VisitOne> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("Avaivable Appointment"),
        actions: [
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty. all(MyColors.mountainMeadow),
            ),
            onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()));},
            child: Text(
              'Home',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ),
        ],
      ),
      floatingActionButton: null,
        body: StreamBuilder(
        stream: DatabaseService().appointmentCollection.where('is_free',isEqualTo: true).snapshots(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            ); 
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              Timestamp temp = document['appointment_date'];
              DateTime dateofvisit = temp.toDate();
              for(int i=0;i<widget.doctors.length;i++){
                if(document['doctor_id']==widget.doctors.elementAt(i).doctorId && widget.doctors.elementAt(i).state ==true)
                {
                  for(int k=0;k<widget.categories.length;k++)
                  {
                    if(widget.doctors.elementAt(i).specId.contains(widget.categories.elementAt(k).specid)&&widget.categories.elementAt(k).state ==true)
                    {
                       if(widget.time.start.isBefore(dateofvisit)&&widget.time.end.isAfter(dateofvisit)&& DateTime.now().isBefore(dateofvisit))
                        return Appointemnt(doctorid: document['doctor_id'],doctorname: widget.doctors.elementAt(i).name, doctorsurname: widget.doctors.elementAt(i).surname , time: document['appointment_date'].toDate(),appointmentid: document['appointment_id'],); 
                    }
                  }
                }
              }
              return SizedBox(height: 0,);
            }).toList(),
          );
        },
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

   Appointemnt({this.doctorid,this.doctorname,this.doctorsurname,this.time,this.appointmentid});
 
   @override
   _AppointemntState createState() => _AppointemntState();
 }
 
 class _AppointemntState extends State<Appointemnt> {
   bool selected = true;
   @override
   Widget build(BuildContext context) {
          return Center(
            child: Column(
            children: [
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30.0,),
                  Row(children: [
                  Text('Doctor name: ' +widget.doctorname,style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ],),
              ],
            ),
            SizedBox(height: 15.0,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30.0,),
                  Row(children: [
                  Text('Doctor Surname: ' +widget.doctorsurname,style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ],),
              ],
            ),
             SizedBox(height: 15.0,),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 30.0,),
                  Row(children: [
                  Text('Time of visit: ' +'${widget.time.month}/${widget.time.day}/${widget.time.year} ${widget.time.hour}:${widget.time.minute}',style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                ],),
              ],
            ),
        ],
      ),
    );
   }
 }