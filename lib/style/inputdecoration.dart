import 'package:flutter/material.dart';
import 'package:clinico/style/colors.dart';

abstract class MyDecoration{
  static var textInputDecoration = InputDecoration(
    fillColor: MyColors.darkSkyBlue,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.darkSkyBlue,width: 2.0),
      borderRadius: BorderRadius.circular(45.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white,width: 2.0),
      borderRadius: BorderRadius.circular(45.0),
    ),
  );
}