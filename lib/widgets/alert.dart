import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAlert({
  required String message,
  required String title,
  required String confirmText,
  required VoidCallback onPressed,
  ButtonType buttonType = ButtonType.info,
  required RxBool lazy,
}) {
  Get.dialog(
    AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      titlePadding: EdgeInsets.only(top: 25, left: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.red[400],
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message),
      actionsPadding: EdgeInsets.only(right: 15, bottom: 10),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
        OutlinedButton(
          style: buttonType == ButtonType.error
              ? OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: BorderSide(color: Colors.red),
                )
              : buttonType == ButtonType.success
                  ? OutlinedButton.styleFrom(
                      foregroundColor: Colors.green[400],
                      side: BorderSide(color: Colors.green[400]!),
                    )
                  : OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                    ),
          onPressed: onPressed,
          child: Obx(() => lazy.value
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0, // Mengatur ketebalan dari indikator
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(confirmText)),
        ),
      ],
    ),
  );
}

enum ButtonType { error, success, info }
