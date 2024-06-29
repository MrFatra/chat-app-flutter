import 'package:chat_app/helper/handler.dart';
import 'package:chat_app/services/dio.service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ContactRepository {
  final DioService _dio = DioService();

  Future<String> getContacts([String? contactName]) async {
    try {
      final request = await _dio.get(
        '/user/contacts',
      );
      if (request.statusCode == 200) {
        debugPrint(request.data.toString());
        debugPrint('success get contacts!');
      } else {
        debugPrint(request.data['message'].toString());
        throw Exception('Error: failed to register!');
      }
      return request.data.runtimeType.toString();
    } on DioException catch (err) {
      throw Exception(handleDioError(err));
    } catch (err) {
      throw Exception(err);
    }
  }
}
