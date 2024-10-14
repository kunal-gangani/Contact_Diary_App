import 'dart:io';

class ContactsModel {
  String phone;
  String name;
  String email;
  File? image;
  List contactsList = [];

  ContactsModel({
    required this.phone,
    required this.name,
    required this.email,
  });
}
