import 'package:flutter/material.dart';
import 'package:clinico/style/colors.dart';

abstract class MyDecoration {
  static var textInputDecoration = InputDecoration(
    hintStyle: TextStyle(color: Colors.white, fontSize: 20),
    fillColor: MyColors.steelTeal.withOpacity(0.4),
    filled: true,
    contentPadding: EdgeInsets.only(left: 20, top: 40),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.white),
        borderRadius: BorderRadius.circular(90)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
      borderRadius: BorderRadius.circular(45.0),
    ),
  );
}
