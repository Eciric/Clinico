import 'package:clinico/screens/admin/usersView.dart';
import 'package:clinico/screens/doctor/appointmentCreating.dart';
import 'package:clinico/screens/doctor/doctor_appointment.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
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
          title: Text("Admin Panel"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                width: MediaQuery.of(context).size.width * 9 / 10,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: MyColors.mountainMeadow.withOpacity(0.80),
                  border: Border.all(
                    width: 2, color: MyColors.mountainMeadow.withOpacity(0.80)),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Text("Email",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Spacer(),
                    Text("Doctor",style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(width: 10,),
                    Text("Admin",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ],
                ),
              ),     
              SizedBox(height: 20,),         
              Expanded(child: UsersView()),
            ],
          ),
        ),
      ),
    );
  }
}
