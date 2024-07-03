import 'package:chat_app/models/user.dart';
import 'package:chat_app/repository/contact.repository.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final ContactRepository _contactRepository = ContactRepository();
  RxList<User> contacts = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    getContacts();
  }

  void getContacts() async {
    final response = await _contactRepository.getContacts();
    contacts.value = response;
  }
}