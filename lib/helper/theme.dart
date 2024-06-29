
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
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: kHeadingTextStyle.copyWith(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: WidgetStateColor.resolveWith(
        (states) {
          if (states
              .containsAll([WidgetState.error, WidgetState.focused])) {
            return Colors.red;
          } else if (states.contains(WidgetState.focused)) {
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
        foregroundColor: WidgetStateProperty.all(Colors.blue),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 13)),
        elevation: WidgetStateProperty.all(7),
        backgroundColor: WidgetStateProperty.all(Colors.blue),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(const TextStyle(
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
          fontSize: 16,
        )),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.blue),
    ).copyWith(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(Colors.blue),
    ).copyWith(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.blue),
      trackColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.5)),
    ).copyWith(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
          return Colors.blue;
        }
        return null;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return null;
        }
        if (states.contains(WidgetState.selected)) {
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

const TextStyle kBodySemiboldStyle = TextStyle(
  fontWeight: FontWeight.w600,
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
