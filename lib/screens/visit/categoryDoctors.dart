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

 List<Category> categories = [];
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
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PickDate(doctors: widget.doctors,categories: categories,),));},
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
              categories.add(Category(specid: document['specializationId'],name: document['specializationName'],state: true,));
              return Category(specid: document['specializationId'],name: document['specializationName'],state: true, category: categories);
            }).toList(),
          );
        },
      ),      
    );
  }
}
 class Category extends StatefulWidget {
   final String name;
   final String specid;
   bool state;
   List<Category> category;

   Category({this.specid,this.name,this.state,this.category});
 
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
                    value: widget.state ?? true,
                    onChanged: (bool val){
                    for(int i=0;i<widget.category.length;i++){
                      if(widget.category.elementAt(i).specid == widget.specid)
                      {
                        setState(() {widget.category.elementAt(i).state = val;});
                      }
                    }
                    setState(() { widget.state = val;});
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