import 'package:flutter/material.dart';
import 'package:clinico/style/colors.dart';

abstract class MyDecoration{
  static var textInputDecoration = InputDecoration(
    fillColor: MyColors.color2,
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.color2,width: 2.0),
      borderRadius: BorderRadius.circular(45.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: MyColors.color3,width: 2.0),
      borderRadius: BorderRadius.circular(45.0),
    ),
  );
}