import 'dart:math';
import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/views/DetailsPage/details_page.dart';
import 'package:contact_diary_app/views/FavouritesPage/favourites_page.dart';
import 'package:contact_diary_app/views/YourContact/your_contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contact_diary_app/views/AddContacts/add_contacts.dart';
import 'package:contact_diary_app/views/DeletedContacts/deleted_contacts.dart';
import 'package:contact_diary_app/views/HiddenContacts/hidden_contacts.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> _authenticate() async {
    try {
      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access Hidden Contacts',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return Consumer<ContactController>(
      builder: (context, value, _) {
        return Scaffold(
          drawer: Drawer(
            elevation: 5,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange[700]!,
                        Colors.orange[500]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                buildDrawerTile(
                  icon: Icons.delete,
                  text: 'Deleted Contacts',
                  onTap: () {
                    Flexify.go(
                      const DeletedContactsPage(),
                      animationDuration: Durations.medium1,
                      animation: FlexifyRouteAnimations.blur,
                    );
                  },
                ),
                buildDrawerTile(
                  icon: Icons.hide_source,
                  text: 'Hidden Contacts',
                  onTap: value.localAuthentication,
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: false,
                backgroundColor: Colors.orange,
                title: Text(
                  "Contacts",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      Flexify.go(
                        const FavouritesPage(),
                        animation: FlexifyRouteAnimations.blur,
                        animationDuration: Durations.medium1,
                      );
                    },
                    icon: const Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Flexify.go(
                        const AddContacts(),
                        animation: FlexifyRouteAnimations.blur,
                        animationDuration: Durations.medium1,
                      );
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      value.changeTheme();
                    },
                    icon: Icon(
                      value.isTheme ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle(
                        "My Profile",
                        value.isTheme,
                      ),
                      SizedBox(
                        height: 75.h,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: value.contactsModel.isTheme
                              ? Colors.grey[800]
                              : Colors.white,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  backgroundColor: Colors.orange[300],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        value.contactsModel.userName,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: value.contactsModel.isTheme
                                              ? Colors.white
                                              : Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        "+91 ${value.contactsModel.userPhone}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: value.contactsModel.isTheme
                                              ? Colors.white70
                                              : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: value.contactsModel.isTheme
                                        ? Colors.white70
                                        : Colors.grey[600],
                                  ),
                                  onPressed: () {
                                    Flexify.go(
                                      YourContact(),
                                      animation: FlexifyRouteAnimations.blur,
                                      animationDuration: Durations.medium1,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      sectionTitle(
                        "Contacts",
                        value.isTheme,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<ContactController>(
                builder: (context, provider, child) {
                  // Create a list of contact tuples (name, phone, email) and sort them
                  List<String> sortedNames =
                      List.from(provider.contactsModel.nameList);
                  sortedNames.sort();

                  List<String> sortedPhones = [];
                  List<String> sortedEmails = [];

                  // Populate the sorted phones and emails based on sorted names
                  for (String name in sortedNames) {
                    int index = provider.contactsModel.nameList.indexOf(name);
                    sortedPhones.add(provider.contactsModel.phoneList[index]);
                    sortedEmails.add(provider.contactsModel.emailList[index]);
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final randomColor = Colors
                            .primaries[random.nextInt(Colors.primaries.length)]
                            .shade300;
                        String name = sortedNames[index];
                        String phone = sortedPhones[index];
                        String email = sortedEmails[index];

                        return Column(
                          children: [
                            Slidable(
                              key: Key(name),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) async {
                                      Uri url = Uri.parse("tel:$phone");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      }
                                    },
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    icon: Icons.call,
                                    label: 'Call',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) async {
                                      Uri smsUrl = Uri.parse("sms:$phone");
                                      if (await canLaunchUrl(smsUrl)) {
                                        await launchUrl(smsUrl);
                                      }
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.message,
                                    label: 'SMS',
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Flexify.go(
                                    DetailPage(
                                      name: name,
                                      phone: phone,
                                      email: email,
                                    ),
                                    animation: FlexifyRouteAnimations.blur,
                                    animationDuration: Durations.medium1,
                                  );
                                },
                                onLongPress: () async {
                                  Uri url = Uri.parse("tel:$phone");
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  }
                                },
                                child: buildContactTile(
                                  name: name,
                                  phone: phone,
                                  randomColor: randomColor,
                                  isThemeDark: value.isTheme,
                                ),
                              ),
                            ),
                            // Updated separator
                            Container(
                              height: 2, // Height of the separator
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8), // Margin around the separator
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey
                                        .withOpacity(0.3), // Light grey color
                                    Colors.transparent, // Transparent color
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: sortedNames.length,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDrawerTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget sectionTitle(
    String title,
    bool isTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: isTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget buildContactTile({
    required String name,
    required String phone,
    required Color randomColor,
    required bool isThemeDark,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: randomColor,
          child: Text(
            name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: isThemeDark ? Colors.white : Colors.black,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Text(
          phone,
          style: TextStyle(
            color: isThemeDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ),
    );
  }
}
