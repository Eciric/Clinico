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
            style: ButtonStyle(backgroundColor: MaterialStateProperty. all(MyColors.mountainMeadow),
            ),
            onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryDoctors(),));},
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
        stream: DatabaseService().doctorsCollection.orderBy('name').snapshots(),
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
                        Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/doctor.jpg'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Row(children: [
                            Text("Name: ",style:  TextStyle(color: Colors.white,fontSize: 20),),
                            Text(document['name'],style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],),
                          Row(children: [
                            Text("Surname: ",style:  TextStyle(color: Colors.white,fontSize: 20),),
                            Text(document['surname'],style:  TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],),
                          Text("Phone Number: " + document['phoneNumber'],style: TextStyle(color: Colors.white, fontSize: 15),),
                        ],),
                        //   value: this.value,
                        // Checkbox(
                        //   onChanged: (value) => setState(() => value = value),
                        // ),
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
