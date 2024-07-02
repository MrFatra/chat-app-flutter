import 'package:chat_app/helper/handler.dart';
import 'package:chat_app/services/dio.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageRepository {
  final DioService _dio = DioService();

  Future<List<Message>> getMessage(String id) async {
    try {
      final request = await _dio.get(
        '/user/chats/$id',
      );
      debugPrint('request data: $request');
      if (request.statusCode == 200) {
        debugPrint(request.data.toString());
        debugPrint('success get messages!');
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to get messages!');
      }
      final data = request.data['messages'];
      return data.map<Message>((json) => Message.fromJson(json)).toList();
    } on DioException catch (err) {
      throw Exception(handleDioError(err));
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<Message> sendMessage(String message, String id) async {
    try {
      final request = await _dio.post(
        '/user/message/send/$id',
        data: {'message': message},
      );
      if (request.statusCode == 200) {
        debugPrint(request.data.toString());
        debugPrint('success send message!');
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to send message!');
      }
      final data = request.data['newMessage'];
      return Message.fromJson(data);
    } on DioException catch (err) {
      throw Exception(handleDioError(err));
    } catch (err) {
      throw Exception(err);
    }
  }
}
