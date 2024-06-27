import 'package:chat_app/models/register.types.dart';
import 'package:chat_app/services/store.service.dart';
import 'package:chat_app/services/url.constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login.types.dart';

class AuthRepository {
  final AuthStorage _authStorage = Get.find<AuthStorage>();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: URL.AUTH_URL,
      contentType: Headers.formUrlEncodedContentType,
      validateStatus: (_) => true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<void> register(TRegister credentials) async {
    try {
      debugPrint(credentials.toJSON().toString());
      final request = await _dio.post('/register', data: credentials.toJSON());
      if (request.statusCode == 200) {
        debugPrint(request.data.toString());
        debugPrint('success registered!');
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to register!');
      }
    } catch (err) {
      debugPrint('Registration error: $err');
    }
  }

  Future<String> login(TLogin credentials) async {
    try {
      final request = await _dio.post('/login', data: credentials.toJSON());
      if (request.statusCode == 200) {
        final String token = request.data['token'];

        debugPrint(request.data['token'].toString());

        await _authStorage.storeToken(token);
        
        debugPrint('success logged in!');

        return request.data['message'];
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to login!');
      }
    } on DioException catch (err) {
      if (err.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection Timeout Exception");
      } else if (err.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive Timeout Exception");
      } else if (err.type == DioExceptionType.sendTimeout) {
        throw Exception("Send Timeout Exception");
      } 
      throw Exception(err.message);
    }
  }
}
