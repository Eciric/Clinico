import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorsView extends StatefulWidget {

  @override
  _DoctorsViewState createState() => _DoctorsViewState();
}

class _DoctorsViewState extends State<DoctorsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("1/4 Pick a Doctor from list"),
      ),
      floatingActionButton: null,
        body: StreamBuilder(
        stream: DatabaseService().doctorsCollection.snapshots(),
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
                    SizedBox(height: 30.0,),
                    Row(
                      children: [
                        SizedBox(width: 30.0,),
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/logo.jpg'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        Column(children: [
                          Text("Name: " + document['name'],style: TextStyle(color: Colors.white, fontSize: 25,),),
                          Text("Surname: " + document['surname'],style: TextStyle(color: Colors.white, fontSize: 25),),
                          Text("Phone Number: " + document['phoneNumber'],style: TextStyle(color: Colors.white, fontSize: 15),),
                        ],)
                    ],)
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
