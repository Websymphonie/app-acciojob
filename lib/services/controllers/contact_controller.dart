import 'dart:convert';

import 'package:acciojob/services/data/repository/contact_repository.dart';
import 'package:acciojob/services/models/contacts.dart';
import 'package:get/get.dart';

class ContactController extends GetxController {
  final ContactRepository contactRepository;

  ContactController({required this.contactRepository});

  late Contact _contact; //Private
  Contact get contact => _contact;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getContact(int id) async {
    Response response = await contactRepository.getContact(id);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      _contact = Contact.fromJson(decodedData);
      _isLoaded = true;
      update();
    } else {}
  }
}
