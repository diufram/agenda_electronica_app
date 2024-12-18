import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

//const String ip = "137.184.145.8";
const String ip = "192.168.0.196";

const String baseURL = "http://$ip:8069/api/";

const String apiKeyNofitication = "bde019e1-c5b5-4852-9135-a829a99244b1";

const backgroundPrimary = Color.fromARGB(255, 69, 74, 72);
const backgroundSecondary = Color.fromARGB(255, 174, 182, 178);
const backgroundOptional = Color.fromARGB(255, 205, 203, 203);
const backgroundOptional1 = Color.fromARGB(255, 213, 203, 194);
ThemeData poppins = ThemeData(
  useMaterial3: true,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 60.sp)), // Muy grande
    displayMedium:
        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 48.sp)), // Grande
    displaySmall:
        GoogleFonts.poppins(textStyle: TextStyle(fontSize: 40.sp)), // Mediano
    headlineLarge: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 34.sp)), // Título grande
    headlineMedium: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 28.sp)), // Título medio
    headlineSmall: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 24.sp)), // Título pequeño
    titleLarge: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 20.sp)), // Subtítulo grande
    titleMedium: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 18.sp)), // Subtítulo mediano
    titleSmall: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16.sp)), // Subtítulo pequeño
    bodyLarge: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16.sp)), // Texto de cuerpo
    bodyMedium: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 14.sp)), // Cuerpo mediano
    bodySmall: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 12.sp)), // Cuerpo pequeño
    labelLarge: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 16.sp)), // Etiqueta grande
    labelMedium: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 14.sp)), // Etiqueta mediana
    labelSmall: GoogleFonts.poppins(
        textStyle: TextStyle(fontSize: 12.sp)), // Etiqueta pequeña
  ),
);

const Map<String, String> headers = {"Content-Type": "application/json"};
