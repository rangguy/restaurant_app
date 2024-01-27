import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFF10D48E);
const Color darkPrimaryColor = Colors.black54;

/// lightheme
ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: secondaryColor,
        onPrimary: secondaryColor,
        secondary: primaryColor,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: secondaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: secondaryColor,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    trackColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return states.contains(MaterialState.selected)
          ? secondaryColor
          : Colors
              .grey; // Set track color to green when selected, grey otherwise
    }),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor:
        MaterialStateProperty.all<Color>(secondaryColor.withOpacity(0.2)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.grey,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue),
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: Colors.black,
    hoverColor: Colors.black,
  ),
);

// dark theme
ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: secondaryColor,
        onPrimary: secondaryColor,
        secondary: darkPrimaryColor,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: secondaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue),
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: Colors.white,
    hoverColor: Colors.white,
  ),
  switchTheme: SwitchThemeData(
    trackColor:
        MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
      return states.contains(MaterialState.selected)
          ? secondaryColor
          : Colors
              .grey; // Set track color to green when selected, grey otherwise
    }),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor:
        MaterialStateProperty.all<Color>(secondaryColor.withOpacity(0.2)),
  ),
);

// variabel tema text aplikasi
final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.poppins(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall:
      GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
