import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Colors.green;
const Color darkPrimaryColor = Colors.black54;
const Color darkSecondaryColor = Color(0xff64ffda);

/// lightheme
ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: primaryColor,
        onPrimary: secondaryColor,
        secondary: secondaryColor,
      ),
  scaffoldBackgroundColor: Colors.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: Colors.green),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: secondaryColor,
      foregroundColor: Colors.green,
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
          ? Colors.green
          : Colors
              .grey; // Set track color to green when selected, grey otherwise
    }),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor:
        MaterialStateProperty.all<Color>(Colors.green.withOpacity(0.2)),
  ),
  cardColor: Colors.green,
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
        primary: darkPrimaryColor,
        onPrimary: Colors.green,
        secondary: Colors.black,
      ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: myTextTheme,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(elevation: 0, backgroundColor: secondaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
    ),
  ),
  cardColor: Colors.green,
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
          ? Colors.green
          : Colors
              .grey; // Set track color to green when selected, grey otherwise
    }),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
    overlayColor:
        MaterialStateProperty.all<Color>(Colors.green.withOpacity(0.2)),
  ),
);

// variabel tema text aplikasi
final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.merriweather(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.merriweather(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.merriweather(
      fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.merriweather(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.merriweather(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.merriweather(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
