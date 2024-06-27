import 'package:chat_app/services/connectivity.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoConnectionScreen extends StatelessWidget {
  final String? callbackRoute;

  NoConnectionScreen({super.key, this.callbackRoute = '/'});

  final ConnectivityController _connectivityController =
      Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('No Internet Connection.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_connectivityController.connected.value) {
                  Get.offNamed(callbackRoute!);
                }
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
