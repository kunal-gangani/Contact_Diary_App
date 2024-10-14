import 'package:contact_diary_app/views/DeletedContacts/deleted_contacts.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary_app/controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
              ),
              title: const Text(
                'Deleted Contacts',
              ),
              onTap: () {
                Flexify.go(
                  const DeletedContactsPage(),
                  animationDuration: Durations.medium1,
                  animation: FlexifyRouteAnimations.blur,
                );
              },
            ),
            ListTile(
              leading: Icon(
                themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              ),
              title: const Text(
                'Change Theme',
              ),
              onTap: () {
                themeController.changeTheme();
                Flexify.back();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10.w,
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search Contacts",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeController.changeTheme();
            },
            icon: Icon(
              themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Profile",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 80.h,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                elevation: 4,
                child: ListTile(
                  leading: const CircleAvatar(
                    radius: 30,
                  ),
                  title: Text(
                    "Kunal Gangani",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    "+91 84608 42328",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Contacts",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (
                  context,
                  index,
                ) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        'C${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      'Contact $index',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "+91 12345 67890",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
