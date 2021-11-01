import 'package:carousel_slider/carousel_slider.dart';
import 'package:clinico/screens/about/about.dart';
import 'package:clinico/screens/appointment/appointment.dart';
import 'package:clinico/screens/info/info.dart';
import 'package:clinico/screens/profile/profile.dart';
import 'package:clinico/style/colors.dart';
import 'package:flutter/material.dart';

class MyCarousel extends StatelessWidget {
  final List _carouselItems = [
    {
      "color": MyColors.mountainMeadow,
      "text": "My profile",
      "onPressed": new ProfileView()
    },
    {
      "color": MyColors.darkSkyBlue,
      "text": "Make an appointment",
      "onPressed": new Appointments()
    },
    {
      "color": MyColors.prussianBlue,
      "text": "Clinic information",
      "onPressed": new Info()
    },
    {"color": MyColors.warmBlack, "text": "About us", "onPressed": new About()},
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: _carouselItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => item['onPressed']))
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                      color: item['color'],
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )),
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '${item['text']}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 32.0, color: Colors.white),
                          )))),
            );
          },
        );
      }).toList(),
    );
  }
}
