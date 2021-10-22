import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryDoctors extends StatefulWidget {

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
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        SizedBox(width: 30.0,),
                        Row(children: [
                            Text("Specialization: ",style:  TextStyle(color: Colors.white,fontSize: 20),),
                            Text(document['specializationName'],style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),      
    );
  }
}