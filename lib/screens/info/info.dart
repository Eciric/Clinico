import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
/*
class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/main_background.png'),
          fit: BoxFit.fill,
        )),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              scale: 0.2,
              image: AssetImage('assets/images/mapa2.png'),
            ),
          ),
        ));
  }
}
*/

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/layout_1.png'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: MyColors.darkSkyBlue,
          elevation: 0.0,
          title: Text("Clinic Info"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
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
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    '------------------------------------------\nScroll down to see map\n------------------------------------------\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset('assets/images/mapa2.png'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
