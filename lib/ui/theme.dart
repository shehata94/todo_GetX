import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr =Color(0xFFFF4667);
const Color White = Colors.white;
const Color  darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);
const primaryClr = bluishClr;

class Themes{

 static final light = ThemeData (
     primaryColor: primaryClr,
     brightness: Brightness.light
 );

 static final dark = ThemeData (
     primaryColor: darkGreyClr,
     brightness: Brightness.dark
 );
}