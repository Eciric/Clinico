import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clinico/style/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.steelTeal,
      child: Center(
        child: SpinKitChasingDots(
          color: MyColors.darkSkyBlue,
          size: 50,
        ),
      ),
    );
  }
}