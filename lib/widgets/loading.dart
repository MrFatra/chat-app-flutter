import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoaderDialog() {
  Get.dialog(
    Center(
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const CupertinoActivityIndicator(
          radius: 15.0,
          color: Colors.blue,
        ),
      ),
    ),
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 700),
  );
}
