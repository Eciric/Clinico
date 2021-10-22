import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/calendar/calendar.dart';
import 'package:clinico/screens/info/info.dart';
import 'package:clinico/screens/receipt/receiptview.dart';
import 'package:clinico/screens/visit/doctors.dart';
import 'package:clinico/screens/visit/visitone.dart';
import 'package:flutter/material.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/style/colors.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
      title: Text('Clinico'),
      backgroundColor: MyColors.darkSkyBlue, 
      elevation: 0.0,
      ),
      drawer: new Drawer(
        child: ListView(
          children: [
            new ListTile(
              tileColor: MyColors.darkSkyBlue,
              leading: Icon(Icons.info,color: Colors.white,),
              title: new Text('About Page'),
              onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );},
              trailing: Wrap(
                children: <Widget>[
                  Icon(Icons.arrow_forward), // icon-1
                ],
              ),
            ),
            new ListTile(
              tileColor: MyColors.darkSkyBlue,
              leading: Icon(Icons.person,color: Colors.white,),
              title: new Text('Sign out'),
              onTap: () async {await _auth.signOut();},
              trailing: Wrap(
                children: <Widget>[
                  Icon(Icons.arrow_forward), // icon-1
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/logo.jpg'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            SizedBox(height: 50,),
                 Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
                ),
            SizedBox(height:50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoctorsView()),
                  );},
                  child:Container(
                    height: 110,
                    width: 110,
                    decoration: new BoxDecoration(
                      color: MyColors.warmBlack,
                    ),
                    child: Icon(Icons.card_travel,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 30,),
                GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReceiptView()),
                  );},
                  child:Container(
                    height: 110,
                    width: 110,
                    decoration: new BoxDecoration(
                      color: MyColors.prussianBlue,
                    ),
                    child: Icon(Icons.local_hospital,color: Colors.white,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendar()),
                  );},
                  child:Container(
                    height: 110,
                    width: 110,
                    decoration: new BoxDecoration(
                      color: MyColors.mountainMeadow,
                    ),
                    child: Icon(Icons.receipt,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 30,),
                GestureDetector(
                  onTap: (){Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Info()),
                  );},
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: new BoxDecoration(
                      color: MyColors.darkSkyBlue,
                    ),
                    child: Icon(Icons.calendar_today,color: Colors.white,),
                  ),
                ),
              ],
            ),
          ],
          ),
      ),
      ),
    );
  }
}