import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../services/socket_io.client.service.dart';

class MessageController extends GetxController {
  RxList<String> messages = <String>[].obs;

  final SocketController _socketController = Get.find<SocketController>();
  
  Socket get socket => _socketController.socket;
  

  void sendMessage(String message) {
    if (socket.connected) {
      socket.emit('new message', message);
    } else {
      debugPrint('Message not sent.');
    }
  }

  void newMessages() {
    if (socket.connected) {
      socket.on('new message', (data) {
        debugPrint('new message: $data');
        messages.add(data);
      });
    } else {
      debugPrint('Unable to get messages.');
    }
  }

}