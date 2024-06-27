import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/helper/theme.dart';
import 'package:chat_app/services/store.service.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final AuthStorage _authStorage = Get.find<AuthStorage>();

  Future<void> _navigateBasedOnAuthStatus(BuildContext context) async {
    bool isLoggedIn = await _authStorage.initializeLoggedInStatus();
    await Future.delayed(const Duration(seconds: 3));
    if (isLoggedIn) {
      Get.offNamed('/');
    } else {
      Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _authStorage.initializeLoggedInStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // Gunakan addPostFrameCallback untuk memastikan navigasi tidak terjadi saat build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateBasedOnAuthStatus(context);
            });

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to',
                    style: kHeadingTextStyle.copyWith(color: Colors.blue),
                  ),
                  Text(
                    'Speak!',
                    style: kHeadingTextStyle.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
