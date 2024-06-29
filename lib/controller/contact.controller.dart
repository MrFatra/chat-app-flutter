import 'package:chat_app/repository/contact.repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final ContactRepository _contactRepository = ContactRepository();
  RxList<String> contacts = <String>[].obs;
  RxString data = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  void getContacts() async {
    final response = await _contactRepository.getContacts();
    data.value = response;
    debugPrint('runtime type: ${data.runtimeType}');
  }
}