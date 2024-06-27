import 'package:chat_app/services/socket_io.client.service.dart';
import 'package:chat_app/services/store.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SocketController connectionController = Get.find<SocketController>();
  final AuthStorage _authStorage = Get.find<AuthStorage>();

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (connectionController.socketConnected.value) {
            return Center(
                child: Column(
              children: [
                const Text('You\'re Connected!'),
                ElevatedButton(
                    onPressed: () async {
                     await _authStorage.logout().then((value) => Get.offAllNamed('/login'));
                    },
                    child: const Text('Logout')),
                Expanded(
                  child: ListView.builder(
                    itemCount: connectionController.messages.length,
                    itemBuilder: (context, index) {
                      return Text(connectionController.messages[index]);
                    },
                  ),
                ),
                TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                      hintText: 'Input message here...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          debugPrint(_messageController.text);
                          connectionController
                              .sendMessage(_messageController.text);
                        },
                      )),
                ),
              ],
            ));
          } else {
            return const Text('Not connected!');
          }
        }),
      ),
    );
  }
}
