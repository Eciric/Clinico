import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.steelTeal,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("Clinic Info"),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      'You can reach us at',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '-----------------------------------',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '(+48) 543-333-222',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'clinico@med.pl',
                      style: TextStyle(
                        fontSize: 26,
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'Adres',
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Łódź 90-413,',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'ul. Piotrkowska 55',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    //FIT IMAGE TO GET THE BEST QUALITY #TODO
                    /* Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/mapa.png'),
                            fit: BoxFit.cover),
                      ),
                    ), */
                  ],
                ))));
  }
}
