import 'package:flutter/material.dart';

String? loginValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fields cannot be empty.';
  }
  return null;
}

String? registerValidator(String? value, {TForm? type = TForm.text, List<String>? passwords}) {
  if (value == null || value.isEmpty) {
    return 'Fields cannot be empty.';
  } else if (value.length < 6 && type == TForm.password) {
    return 'Password must be at least 6 characters.';
  } else if (passwords != null && passwords[0] != passwords[1] && type != TForm.password) {
    return 'Passwords do not match.';
  }
  return null;
}

bool validate(GlobalKey<FormState> formKey) {
  if (formKey.currentState?.validate() ?? false) {
    return true;
  }
  return false;
}

enum TForm { password, text }