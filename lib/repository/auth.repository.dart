import 'package:chat_app/helper/handler.dart';
import 'package:chat_app/models/register.types.dart';
import 'package:chat_app/services/store.service.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/login.types.dart';
import '../services/dio.service.dart';

class AuthRepository {
  final AuthStorage _authStorage = Get.find<AuthStorage>();
  final DioService _dio = DioService();
  final _cookieJar = CookieJar();

  Future<void> register(TRegister credentials) async {
    try {
      debugPrint(credentials.toJSON().toString());
      final request =
          await _dio.post('/auth/register', data: credentials.toJSON());
      if (request.statusCode == 200) {
        debugPrint(request.data.toString());
        debugPrint('success registered!');
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to register!');
      }
    } on DioException catch (err) {
      throw Exception(handleDioError(err));
    } catch (err) {
      debugPrint('Registration error: $err');
    }
  }

  Future<String> login(TLogin credentials) async {
    try {
      final request =
          await _dio.post('/auth/login', data: credentials.toJSON());

      if (request.statusCode == 200) {
        final String token = request.data['token'];

        debugPrint('cookie: ' + (await _cookieJar.loadForRequest(Uri.parse("http://localhost:3000/api/auth/login"))).toString());

        debugPrint(request.data['token'].toString());

        await _authStorage.storeToken(token);

        debugPrint('success logged in!');

        return request.data['message'];
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to login!');
      }
    } on DioException catch (err) {
      throw Exception(handleDioError(err));
    } catch (err) {
      debugPrint('Login error: $err');
      throw Exception(err);
    }
  }
}
