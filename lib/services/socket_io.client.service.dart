import 'package:chat_app/services/url.constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late final IO.Socket _socket;

  var messages = [].obs;
  var socketConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  @override
  void onClose() {
    super.onClose();
    _socket.dispose();
  }

  void connectToSocket() {
    _socket = IO.io(
        URL.SOCKET_HOST,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection()
            .build());

    _socket.onConnect((_) {
      socketConnected.value = true;
      debugPrint('Connected to the server!');
      newMessages();
      debugPrint('Your socket id is ${_socket.id}');
    });

    _socket.onReconnect((data) {
      debugPrint('Reconnected to the server!');
    });

    _socket.onReconnectAttempt((data) {
      debugPrint('Reconnecting to the server...');
    });

    _socket.onReconnectError((data) {
      socketConnected.value = false;
      debugPrint('Error reconnecting to the server: $data');
    });

    _socket.onReconnectFailed((data) {
      socketConnected.value = false;
      debugPrint('Failed to reconnect to the server: $data');
    });

    _socket.onConnectError((data) {
      socketConnected.value = false;
      debugPrint('Connection error: $data');
    });

    _socket.onDisconnect((data) {
      socketConnected.value = false;
      debugPrint('Disconnected: $data');
    });
  }

  void sendMessage(String message) {
    if (_socket.connected) {
      _socket.emit('new message', message);
    } else {
      debugPrint('Message not sent.');
    }
  }

  void newMessages() {
    if (_socket.connected) {
      _socket.on('new message', (data) {
        debugPrint('new message: $data');
        messages.add(data);
      });
    } else {
      debugPrint('Unable to get messages.');
    }
  }
}
