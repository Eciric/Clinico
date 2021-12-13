import 'package:clinico/screens/visit/pickDate.dart';
import 'package:clinico/services/database.dart';
import 'package:clinico/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TakeCategory extends StatefulWidget {
  String userid;
  String role;
  String name;
  String surname;
  String phonenumber;
  TakeCategory(
      {this.userid, this.role, this.name, this.surname, this.phonenumber});
  @override
  _TakeCategoryState createState() => _TakeCategoryState();
}

class _TakeCategoryState extends State<TakeCategory> {
  List<String> categories = [];
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("Doctor Specialization "),
          actions: [
            TextButton(
                onPressed: () async {
                  updateDoctorperrmision(
                      widget.userid,
                      widget.role,
                      widget.name,
                      categories,
                      widget.surname,
                      widget.phonenumber);
                  Navigator.pop(context);
                },
                child: Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
        floatingActionButton: null,
        body: StreamBuilder(
          stream: DatabaseService()
              .specializatonCollection
              .orderBy('specializationName')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.docs.map((document) {
                categories.add(document['specializationId']);
                return Category(
                    specid: document['specializationId'],
                    name: document['specializationName'],
                    state: true,
                    category: categories);
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  updateDoctorperrmision(String userid, String role, String name,
      List<String> specid, String surname, String phonenumber) async {
    await DatabaseService(uid: userid)
        .updateDoctorPermissions(role == 'doctor' ? 'user' : 'doctor', userid);
    await DatabaseService(uid: userid)
        .updateDoctorPermissions2(userid, name, phonenumber, specid, surname);
  }
}

class Category extends StatefulWidget {
  final String name;
  final String specid;
  bool state;
  List<String> category;

  Category({this.specid, this.name, this.state, this.category});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 4 / 5,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          decoration: BoxDecoration(
              color: MyColors.mountainMeadow.withOpacity(0.80),
              border: Border.all(
                  width: 2, color: MyColors.mountainMeadow.withOpacity(0.80)),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 12 * 5,
                        child: Text(
                          widget.name ?? "test",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Checkbox(
                        activeColor: Color.fromRGBO(32, 125, 96, 1),
                        value: widget.state ?? true,
                        onChanged: (bool val) {
                          if (widget.category.contains(widget.specid)) {
                            widget.category.remove(widget.specid);
                          } else {
                            widget.category.add(widget.specid);
                          }
                          setState(() {
                            widget.state = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
