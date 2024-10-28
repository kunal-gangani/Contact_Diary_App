import 'dart:math';
import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/views/DetailsPage/details_page.dart';
import 'package:contact_diary_app/views/FavouritesPage/favourites_page.dart';
import 'package:contact_diary_app/views/YourContact/your_contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contact_diary_app/controllers/theme_controller.dart';
import 'package:contact_diary_app/views/AddContacts/add_contacts.dart';
import 'package:contact_diary_app/views/DeletedContacts/deleted_contacts.dart';
import 'package:contact_diary_app/views/HiddenContacts/hidden_contacts.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    final random = Random();

    return Consumer<ThemeController>(
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
                _buildDrawerTile(
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
                _buildDrawerTile(
                  icon: Icons.hide_source,
                  text: 'Hidden Contacts',
                  onTap: () {
                    Flexify.go(
                      const HiddenContacts(),
                      animationDuration: Durations.medium1,
                      animation: FlexifyRouteAnimations.blur,
                    );
                  },
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
                      themeController.changeTheme();
                    },
                    icon: Icon(
                      themeController.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        "My Profile",
                        value.isTheme,
                      ),
                      _buildProfileCard(value.isTheme),
                      SizedBox(height: 20.h),
                      _sectionTitle(
                        "Contacts",
                        value.isTheme,
                      ),
                    ],
                  ),
                ),
              ),
              Consumer<ContactController>(
                builder: (context, provider, child) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final randomColor = Colors
                          .primaries[random.nextInt(
                        Colors.primaries.length,
                      )]
                          .shade300;
                      String name = provider.contactsModel.nameList[index];
                      String phone = provider.contactsModel.phoneList[index];
                      String email = provider.contactsModel.emailList[index];
                      return Column(
                        children: [
                          Slidable(
                            key: Key(name),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) async {
                                    Uri url = Uri.parse(
                                      "tel:$phone",
                                    );
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
                              child: _buildContactTile(
                                name: name,
                                phone: phone,
                                randomColor: randomColor,
                                isThemeDark: value.isTheme,
                              ),
                            ),
                          ),
                          Divider(
                            height: 1.5.h,
                            color: Colors.grey[400],
                          ),
                        ],
                      );
                    },
                    childCount: provider.contactsModel.nameList.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawerTile(
      {required IconData icon,
      required String text,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _sectionTitle(String title, bool isDarkTheme) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: isDarkTheme ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildProfileCard(bool isDarkTheme) {
    return SizedBox(
      height: 75.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: isDarkTheme ? Colors.grey[800] : Colors.white,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Kunal Gangani",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : Colors.black87,
                      ),
                    ),
                    Text(
                      "+91 84608 42328",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDarkTheme ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: isDarkTheme ? Colors.white70 : Colors.grey[600],
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
    );
  }

  Widget _buildContactTile({
    required String name,
    required String phone,
    required Color randomColor,
    required bool isThemeDark,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: randomColor,
        child: Text(
          name[0],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: isThemeDark ? Colors.white : Colors.black87,
        ),
      ),
      subtitle: Text(
        phone,
        style: TextStyle(
          fontSize: 13.sp,
          color: isThemeDark ? Colors.white70 : Colors.grey[600],
        ),
      ),
    );
  }
}
