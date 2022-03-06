import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme txt = TextTheme(
  headline6: GoogleFonts.nunito(
    fontSize: 25,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
  caption: GoogleFonts.nunito(
    fontSize: 18,
    color: Colors.grey,
  ),
  bodyText1: GoogleFonts.nunito(
    fontSize: 22,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  ),
);

ThemeData light = ThemeData(
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor:  Color.fromARGB(255, 255, 251, 251),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ),
  ),
  textTheme: txt,
);
