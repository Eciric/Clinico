import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.steelTeal,
      appBar: AppBar(
        backgroundColor: MyColors.darkSkyBlue,
        elevation: 0.0,
        title: Text("About App"),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            color: MyColors.warmBlack,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              'Team Members',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Marcin Kobus',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.warmBlack)),
            onPressed: _launchMARCIN,
            child: new Text('Show Marcin Github'),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Przemysław Kaczmarski',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.warmBlack)),
            onPressed: _launchPRZEMEK,
            child: new Text('Show Przemek Github'),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Krzysztof Pijanowski',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(MyColors.warmBlack)),
            onPressed: _launchKRZYSIEK,
            child: new Text('Show Krzysiek Github'),
          ),
        ],
      )),
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
  const url = 'https://github.com/marcin62?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchKRZYSIEK() async {
  const url = 'https://github.com/marcin62?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
