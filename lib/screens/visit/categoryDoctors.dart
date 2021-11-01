import 'package:clinico/screens/visit/pickDate.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'doctors.dart';

class CategoryDoctors extends StatefulWidget {

  List<Doctor> doctors;
  CategoryDoctors({this.doctors});

  @override
  _CategoryDoctorsState createState() => _CategoryDoctorsState();
}

class _CategoryDoctorsState extends State<CategoryDoctors> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("2/4 Pick a Specialization from list"),
        actions: [
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty. all(MyColors.mountainMeadow),
            ),
            onPressed: (){
              
              // DatabaseService().addNewAppointmentToDatabase("7", "2", null, "2", false, false, true, "bol glowy", DateTime.now(), DateTime.now());
              // DatabaseService().addNewAppointmentToDatabase("8", "2", null, "2", false, false, true, "bol glowy", DateTime.now(), DateTime.now());
              // DatabaseService().addNewAppointmentToDatabase("9", "3", null, "2", false, false, true, "bol glowy", DateTime.now(), DateTime.now());
              // DatabaseService().addNewAppointmentToDatabase("10", "4", null, "2", false, false, true, "bol glowy", DateTime.now(), DateTime.now());
              // DatabaseService().addNewAppointmentToDatabase("11", "5", null, "2", false, false, true, "bol glowy", DateTime.now(), DateTime.now());

              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PickDate(doctors: widget.doctors,),));},
            child: Text(
              'Go Next',
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
        stream: DatabaseService().specializatonCollection.orderBy('specializationName').snapshots(),
        builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            ); 
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return Category(name: document['specializationName']);
            }).toList(),
          );
        },
      ),      
    );
  }
}
 class Category extends StatefulWidget {
   final String name;

   Category({this.name});
 
   @override
   _CategoryState createState() => _CategoryState();
 }
 
 class _CategoryState extends State<Category> {
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
                  Text(widget.name??"test",style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  Checkbox(
                    activeColor: MyColors.mountainMeadow,
                    value: selected ?? true,
                    onChanged: (bool val){
                    setState(() { selected = val;});
                  },),
                ],),
              ],
            ),
            SizedBox(height: 15.0,),
        ],
      ),
    );
   }
 }