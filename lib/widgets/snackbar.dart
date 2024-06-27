import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String title, String message,
    [TSnackbar type = TSnackbar.info]) {
    Get.snackbar(
      title,
      message,
      backgroundColor: type == TSnackbar.error
          ? Colors.red
          : type == TSnackbar.success
              ? const Color(0xFF44F84A)
              : Colors.blue,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      icon: type == TSnackbar.error
          ? const Icon(Icons.error_outline_rounded, color: Colors.white)
          : type == TSnackbar.success
              ? const Icon(Icons.check, color: Colors.white)
              : const Icon(Icons.info, color: Colors.white),
    );
}

enum TSnackbar { info, success, error }
