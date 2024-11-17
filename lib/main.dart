import 'package:contact_diary_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//------------------------------------
List<String> nameList = [];
List<String> emailList = [];
List<String> phoneList = [];
//------------------------------------
List<String> deletedNameList = [];
List<String> deletedPhoneList = [];
List<String> deletedEmailList = [];
//------------------------------------
List<String> favNameList = [];
List<String> favPhoneList = [];
List<String> favEmailList = [];
//------------------------------------
bool? isTheme;
//------------------------------------
List<String> hiddenNameList = [];
List<String> hiddenPhoneList = [];
List<String> hiddenEmailList = [];
//------------------------------------
String userName = "";
String userPhone = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  nameList = preferences.getStringList('nameList') ?? [];
  phoneList = preferences.getStringList('phoneList') ?? [];
  emailList = preferences.getStringList('emailList') ?? [];

  //Deleted Contacts
  deletedNameList = preferences.getStringList('deletedNameList') ?? [];
  deletedPhoneList = preferences.getStringList('deletedPhoneList') ?? [];
  deletedEmailList = preferences.getStringList('deletedEmailList') ?? [];

  //Favorite Contacts
  favNameList = preferences.getStringList('favNameList') ?? [];
  favPhoneList = preferences.getStringList('favPhoneList') ?? [];
  favEmailList = preferences.getStringList('favEmailList') ?? [];

  //Theme
  isTheme = preferences.getBool('isTheme') ?? true;

  //Hidden Contacts
  hiddenNameList = preferences.getStringList('hiddenNameList') ?? [];
  hiddenPhoneList = preferences.getStringList('hiddenPhoneList') ?? [];
  hiddenEmailList = preferences.getStringList('hiddenEmailList') ?? [];

  //User Data
  userName = preferences.getString('userName') ?? "John Doe";
  userPhone = preferences.getString('userPhone') ?? "1234567890";

  runApp(
    const MyApp(),
  );
}
