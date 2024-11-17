class ContactsModel {
  bool isTheme;
  List<String> phoneList;
  List<String> nameList;
  List<String> emailList;

  // Favourite
  List<String> favNameList;
  List<String> favEmailList;
  List<String> favPhoneList;

  // Delete
  List<String> deletedNameList;
  List<String> deletedPhoneList;
  List<String> deletedEmailList;

  // Hide
  List<String> hiddenNameList;
  List<String> hiddenPhoneList;
  List<String> hiddenEmailList;

  // User Data
  String userName;
  String userPhone;

  ContactsModel({
    required this.phoneList,
    required this.nameList,
    required this.emailList,
    this.isTheme = false,
    List<String>? favNameList,
    List<String>? favEmailList,
    List<String>? favPhoneList,
    List<String>? deletedNameList,
    List<String>? deletedPhoneList,
    List<String>? deletedEmailList,
    List<String>? hiddenNameList,
    List<String>? hiddenPhoneList,
    List<String>? hiddenEmailList,
    String? userName,
    String? userPhone,
  })  : favNameList = favNameList ?? [],
        favEmailList = favEmailList ?? [],
        favPhoneList = favPhoneList ?? [],
        deletedNameList = deletedNameList ?? [],
        deletedPhoneList = deletedPhoneList ?? [],
        deletedEmailList = deletedEmailList ?? [],
        hiddenNameList = hiddenNameList ?? [],
        hiddenPhoneList = hiddenPhoneList ?? [],
        hiddenEmailList = hiddenEmailList ?? [],
        userName = userName ?? "John Doe",
        userPhone = userPhone ?? "1234567890";
}
