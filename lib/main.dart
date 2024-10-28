import 'package:contact_diary_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> nameList = [];
List<String> emailList = [];
List<String> phoneList = [];
List<String> deletedNameList = [];
List<String> deletedPhoneList = [];
List<String> deletedEmailList = [];
List<String> favNameList = [];
List<String> favPhoneList = [];
List<String> favEmailList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  nameList = preferences.getStringList('nameList') ?? [];
  phoneList = preferences.getStringList('phoneList') ?? [];
  emailList = preferences.getStringList('emailList') ?? [];

  deletedNameList = preferences.getStringList('deletedNameList') ?? [];
  deletedPhoneList = preferences.getStringList('deletedPhoneList') ?? [];
  deletedEmailList = preferences.getStringList('deletedEmailList') ?? [];

  //Favorite contacts
  favNameList = preferences.getStringList('favNameList') ?? [];
  favPhoneList = preferences.getStringList('favPhoneList') ?? [];
  favEmailList = preferences.getStringList('favEmailList') ?? [];

  runApp(
    const MyApp(),
  );
}
