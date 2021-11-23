import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
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
        title: Text("About Page"),
      ),
      body: Center(
          child: Column(
              children: [
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.mountainMeadow.withOpacity(0.7),
                      border: Border.all(
                          width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(child:Text("Team Members",style: TextStyle(color: Colors.white,fontSize: 30)))
                ),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.mountainMeadow.withOpacity(0.7),
                      border: Border.all(
                          width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                       Text(
                        'Marcin Kobus',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(250, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.darkSkyBlue.withOpacity(0.5)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(90.0)))),
                        child: Text(
                          'Marcin Github',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                         _launchMARCIN();
                        },
                      ),
                    ],
    
                  )
                  ),
                  SizedBox(height: 20,),
                  Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.mountainMeadow.withOpacity(0.7),
                      border: Border.all(
                          width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                       Text(
                        'Krzysztof Pijanowski',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(250, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.darkSkyBlue.withOpacity(0.5)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(90.0)))),
                        child: Text(
                          'Krzysiek Github',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                         _launchKRZYSIEK()();
                        },
                      ),
                    ],
    
                  )
                  ),
                  SizedBox(height: 20,),
                  Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.mountainMeadow.withOpacity(0.7),
                      border: Border.all(
                          width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                       Text(
                        'Przemysław Kaczmarski',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(250, 50)),
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.darkSkyBlue.withOpacity(0.5)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(90.0)))),
                        child: Text(
                          'Przemek Github',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () async {
                        _launchPRZEMEK()();
                        },
                      ),
                    ],
    
                  )
                  ),
                  SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  decoration: BoxDecoration(
                      color: MyColors.mountainMeadow.withOpacity(0.7),
                      border: Border.all(
                          width: 2, color: MyColors.mountainMeadow.withOpacity(0.7)),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(child:Column(children:[Text("Description",style: TextStyle(color: Colors.white,fontSize: 22)),
                  Text("Clinic app version 1.0",style: TextStyle(color: Colors.white,fontSize: 20))]))
                ),
              ])
      )
      )
      );
  }
}

_launchMARCIN() async {
  const url = 'https://github.com/marcin62?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchPRZEMEK() async {
  const url = 'https://github.com/Eciric?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchKRZYSIEK() async {
  const url = 'https://github.com/Kryszczyn99?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
