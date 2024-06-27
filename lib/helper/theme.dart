import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: 'Poppins',
    useMaterial3: true,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    hintColor: Colors.blue, // Use this for older versions of Flutter
    indicatorColor: Colors.blue, // Switch, Radio, and Checkbox
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.blue,
      selectionHandleColor: Colors.blue,
      selectionColor: Colors.blue,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: MaterialStateColor.resolveWith(
        (states) {
          if (states
              .containsAll([MaterialState.error, MaterialState.focused])) {
            return Colors.red;
          } else if (states.contains(MaterialState.focused)) {
            return Colors.blue;
          } else {
            return Colors.black45;
          }
        },
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.grey[400],
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black54, width: 1.3),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.blue),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13)),
        elevation: MaterialStateProperty.all(7),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        textStyle: MaterialStateProperty.all(const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
          fontSize: 16,
        )),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.blue),
    ).copyWith(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(Colors.blue),
    ).copyWith(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blue),
      trackColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.5)),
    ).copyWith(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
    ),
  );
}

// Define constant text styles
const TextStyle kBodyTextStyle = TextStyle(
  fontWeight: FontWeight.normal,
  color: Colors.black87,
);

const TextStyle kBodyMediumTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.black87,
);

const TextStyle kHeadingTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
);

const TextStyle kSubtitleTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.grey,
);

const TextStyle kBodySmallTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black87,
);

const TextStyle kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  letterSpacing: 0.5,
);
