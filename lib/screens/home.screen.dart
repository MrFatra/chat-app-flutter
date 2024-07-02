import 'package:chat_app/controller/contact.controller.dart';
import 'package:chat_app/screens/chat.screen.dart';
import 'package:chat_app/services/socket_io.client.service.dart';
import 'package:chat_app/services/store.service.dart';
import 'package:chat_app/widgets/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/contact.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SocketController connectionController = Get.find<SocketController>();
  final AuthStorage _authStorage = Get.find<AuthStorage>();
  final ContactController _contactController =
      Get.put<ContactController>(ContactController());

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // final RxList<Contacts> contacts = [].obs;
  final isLoading = false.obs;

  void logout() async {
    isLoading.value = true;
    try {
      await _authStorage.logout().then((value) => Get.offAllNamed('/login'));
    } catch (err) {
      debugPrint(err.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showAlert(
                title: 'Warning',
                message: 'Are you sure want to logout?',
                confirmText: 'Logout',
                buttonType: ButtonType.error,
                lazy: isLoading,
                onPressed: logout,
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (connectionController.socketConnected.value &&
              _contactController.contacts.isNotEmpty) {
            return Center(
              child: Column(
                children: [
                  // list of contact widget
                  Expanded(
                    child: ListView.builder(
                      itemCount: _contactController.contacts.length,
                      itemBuilder: (context, index) {
                        final user = _contactController.contacts[index];
                        return InkWell(
                            onTap: () => Get.toNamed('/chat',
                                arguments: {'user': user}),
                            child: ContactWidget(user: user));
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Not connected!');
          }
        }),
      ),
    );
  }
}
