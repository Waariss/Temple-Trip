import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: GoogleFonts.ibmPlexSansThaiLooped().fontFamily,
  );
}
