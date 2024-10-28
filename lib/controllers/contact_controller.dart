import 'package:contact_diary_app/main.dart';
import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactController extends ChangeNotifier {
  ContactsModel contactsModel;

  ContactController({
    required this.contactsModel,
  });

  Future<void> addContactData({
    required String name,
    required String phone,
    required String email,
  }) async {
    if (phoneList.contains(phone)) {
    } else {
      contactsModel.nameList.add(name);
      contactsModel.emailList.add(email);
      contactsModel.phoneList.add(phone);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setStringList('nameList', contactsModel.nameList);
      preferences.setStringList('emailList', contactsModel.emailList);
      preferences.setStringList('phoneList', contactsModel.phoneList);

      notifyListeners();
    }
  }

  Future<void> deleteContact({
    required String name,
    required String phone,
    required String email,
  }) async {
    deleteContact(
      name: name,
      phone: phone,
      email: email,
    );
    contactsModel.nameList.remove(name);
    contactsModel.emailList.remove(email);
    contactsModel.phoneList.remove(phone);

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setStringList('nameList', contactsModel.nameList);
    preferences.setStringList('emailList', contactsModel.emailList);
    preferences.setStringList('phoneList', contactsModel.phoneList);

    notifyListeners();
  }

  Future<void> setDeletedContacts({
    required String name,
    required String phone,
    required String email,
  }) async {
    contactsModel.deletedNameList.add(name);
    contactsModel.deletedPhoneList.add(phone);
    contactsModel.deletedEmailList.add(email);

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('deletedNameList', contactsModel.deletedNameList);
    pref.setStringList('deletedPhoneList', contactsModel.deletedPhoneList);
    pref.setStringList('deletedEmailList', contactsModel.deletedEmailList);

    notifyListeners();
  }

  Future<void> setFavourites({
    required String name,
    required String phone,
    required String email,
  }) async {
    if (favPhoneList.contains(phone)) {
      contactsModel.favNameList.add(name);
      contactsModel.favPhoneList.add(phone);
      contactsModel.favEmailList.add(email);

      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setStringList('favNameList', contactsModel.favNameList);
      preferences.setStringList('favPhoneList', contactsModel.favPhoneList);
      preferences.setStringList('favEmailList', contactsModel.favEmailList);

      notifyListeners();
    }
  }
}
