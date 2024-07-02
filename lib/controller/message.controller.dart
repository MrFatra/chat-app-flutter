import 'package:chat_app/repository/message.repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/message.dart';
import '../services/socket_io.client.service.dart';

class MessageController extends GetxController {
  final String id;

  MessageController({required this.id});

  RxList<Message> messages = <Message>[].obs;

  final SocketController _socketController = Get.find<SocketController>();
  final MessageRepository _messageRepository = MessageRepository();

  @override
  void onInit() async {
    super.onInit();
    await getMessage(id);
  }

  @override
  void onReady() {
    super.onReady();
    newMessages();
  }

  Future<void> getMessage(String id) async {
    debugPrint('id getMessage: $id');
    try {
    final response = await _messageRepository.getMessage(id);
    debugPrint(response.toString());
    messages.value = response;
    } catch (err) {
      debugPrint(err.toString());
    }
    
  }

  Future<void> sendMessage(String message, String id) async {
    final response = await _messageRepository.sendMessage(message, id);
    debugPrint(response.toString());
    if (_socketController.socket.connected) {
      _socketController.socket.emit('new message', response);
    } else {
      debugPrint('Message not sent.');
    }
  }

  void newMessages() {
    debugPrint('test');
    if (_socketController.socket.connected) {
      _socketController.socket.on('new message', (data) {
        debugPrint('new message: $data');
        messages.add(Message.fromJson(data));
      });
    } else {
      debugPrint('Unable to get messages.');
    }
  }
}
