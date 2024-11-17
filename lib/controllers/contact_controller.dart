import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:contact_diary_app/views/HiddenContacts/hidden_contacts.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactController extends ChangeNotifier {
  ContactsModel contactsModel;
  bool isTheme;
  final key = GlobalKey();

  ContactController({
    required this.contactsModel,
  }) : isTheme = contactsModel.isTheme;

  Future<void> initializeData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    isTheme = preferences.getBool('isTheme') ?? contactsModel.isTheme;
    contactsModel.userName =
        preferences.getString('userName') ?? contactsModel.userName;
    contactsModel.userPhone =
        preferences.getString('userPhone') ?? contactsModel.userPhone;

    notifyListeners();
  }

  void changeTheme() async {
    isTheme = !isTheme;
    contactsModel.isTheme = isTheme;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isTheme', isTheme);

    notifyListeners();
  }

  Future<void> addContactData({
    required String name,
    required String phone,
    required String email,
  }) async {
    if (contactsModel.phoneList.contains(phone)) return;

    contactsModel.nameList.add(name);
    contactsModel.emailList.add(email);
    contactsModel.phoneList.add(phone);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('nameList', contactsModel.nameList);
    await preferences.setStringList('emailList', contactsModel.emailList);
    await preferences.setStringList('phoneList', contactsModel.phoneList);

    notifyListeners();
  }

  Future<void> deleteContact({
    required String name,
    required String phone,
    required String email,
  }) async {
    contactsModel.nameList.remove(name);
    contactsModel.emailList.remove(email);
    contactsModel.phoneList.remove(phone);

    contactsModel.deletedNameList.add(name);
    contactsModel.deletedPhoneList.add(phone);
    contactsModel.deletedEmailList.add(email);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('nameList', contactsModel.nameList);
    await preferences.setStringList('emailList', contactsModel.emailList);
    await preferences.setStringList('phoneList', contactsModel.phoneList);
    await preferences.setStringList(
        'deletedNameList', contactsModel.deletedNameList);
    await preferences.setStringList(
        'deletedPhoneList', contactsModel.deletedPhoneList);
    await preferences.setStringList(
        'deletedEmailList', contactsModel.deletedEmailList);

    notifyListeners();
  }

  Future<void> setFavourites({
    required String name,
    required String phone,
    required String email,
  }) async {
    if (contactsModel.favPhoneList.contains(phone)) return;

    contactsModel.favNameList.add(name);
    contactsModel.favPhoneList.add(phone);
    contactsModel.favEmailList.add(email);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('favNameList', contactsModel.favNameList);
    await preferences.setStringList('favPhoneList', contactsModel.favPhoneList);
    await preferences.setStringList('favEmailList', contactsModel.favEmailList);

    notifyListeners();
  }

  Future<void> hideContacts({
    required String name,
    required String phone,
    required String email,
  }) async {
    contactsModel.hiddenNameList.add(name);
    contactsModel.hiddenPhoneList.add(phone);
    contactsModel.hiddenEmailList.add(email);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('hiddenName', contactsModel.hiddenNameList);
    await preferences.setStringList(
        'hiddenPhone', contactsModel.hiddenPhoneList);
    await preferences.setStringList(
        'hiddenEmail', contactsModel.hiddenEmailList);

    notifyListeners();
  }

  Future<void> updateUserDetails({
    required String name,
    required String phone,
  }) async {
    contactsModel.userName = name;
    contactsModel.userPhone = phone;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('userName', name);
    await preferences.setString('userPhone', phone);

    notifyListeners();
  }

  Future<void> updateContactsDetails({
    required String name,
    required String phone,
    required String email,
  }) async {
    int index = contactsModel.phoneList.indexOf(phone);

    if (index != -1) {
      contactsModel.nameList[index] = name;
      contactsModel.emailList[index] = email;

      SharedPreferences preferences = await SharedPreferences.getInstance();

      await preferences.setStringList('nameList', contactsModel.nameList);
      await preferences.setStringList('phoneList', contactsModel.phoneList);
      await preferences.setStringList('emailList', contactsModel.emailList);

      notifyListeners();
    } else {
      throw Exception("Contact not found");
    }
  }

  void sortContactsChronologically() {
    List<Map<String, dynamic>> combinedList = [];
    for (int i = 0; i < contactsModel.nameList.length; i++) {
      combinedList.add({
        'name': contactsModel.nameList[i],
        'phone': contactsModel.phoneList[i],
        'email': contactsModel.emailList[i],
      });
    }

    combinedList.sort((a, b) => a['date'].compareTo(b['date']));

    contactsModel.nameList.clear();
    contactsModel.phoneList.clear();
    contactsModel.emailList.clear();

    for (var contact in combinedList) {
      contactsModel.nameList.add(contact['name']);
      contactsModel.phoneList.add(contact['phone']);
      contactsModel.emailList.add(contact['email']);
    }

    notifyListeners();
  }

  void localAuthentication() async {
    LocalAuthentication localAuth = LocalAuthentication();
    bool isBiometricAvailable = await localAuth.canCheckBiometrics;
    if (isBiometricAvailable) {
      bool isAuth = await localAuth.authenticate(
        localizedReason: "Required Authenticate",
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
      if (isAuth) {
        Flexify.go(
          HiddenContacts(
            key: key,
          ),
          animation: FlexifyRouteAnimations.blur,
          animationDuration: Durations.medium1,
        );
      }
    }
  }
}
