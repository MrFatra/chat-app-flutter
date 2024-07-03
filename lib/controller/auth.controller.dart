import 'package:chat_app/helper/types.dart';
import 'package:chat_app/repository/auth.repository.dart';
import 'package:chat_app/widgets/loading.dart';
import 'package:chat_app/widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  Rx<bool> isLoading = false.obs;

  void register(TRegister credentials) async {
    String error = '';
    isLoading.value = true;
    showLoaderDialog();
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _authRepository.register(credentials);
      return response;
    } on DioException catch (err) {
      error = err.toString();
      debugPrint('Error: $err');
    } on Exception catch (err) {
      error = err.toString();
      debugPrint('Error exception: $err');
    } catch (err) {
      error = err.toString();
      debugPrint('Error unknown: $err');
    } finally {
      if (Get.isDialogOpen == true) Get.back();
      if (error != '') showCustomSnackbar('Warning', error, TSnackbar.error);
      isLoading.value = false;
    }
  }

  void login(TLogin credentials) async {
    String error = '';
    isLoading.value = true;
    showLoaderDialog();
    await Future.delayed(const Duration(seconds: 1));
    try {
      final response = await _authRepository.login(credentials);
      showCustomSnackbar('Success', response);
      Get.offAllNamed('/');
    } on DioException catch (err) {
      error = err.toString();
      debugPrint('Error: $err');
    } on Exception catch (err) {
      error = err.toString();
      debugPrint('Error exception: $err');
    } catch (err) {
      error = err.toString();
      debugPrint('Error unknown: $err');
    } finally {
      if (Get.isDialogOpen == true) Get.back();
      if (error != '') showCustomSnackbar('Warning', error, TSnackbar.error);
      isLoading.value = false;
    }
  }
}
