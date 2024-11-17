import 'package:contact_diary_app/controllers/bottom_navaigation_bar_controller.dart';
import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/views/EditContacts/edit_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:provider/provider.dart';
// import 'package:share_extend/share_extend.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String phone;
  final String email;

  const DetailPage({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4,
        leading: IconButton(
          onPressed: () {
            Flexify.goRemove(
              HomePage(),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ContactController>(
                context,
                listen: false,
              ).setFavourites(
                name: name,
                phone: phone,
                email: email,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$name has been added to favorites',
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.star_border_outlined,
              color: Colors.white,
              size: 30.h,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 130.w,
              height: 130.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue,
                    Colors.purple,
                    Colors.red,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  name[0],
                  style: TextStyle(
                    fontSize: 45.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Contact Number",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email ID",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Consumer<ContactController>(builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    Icons.call,
                    "Call",
                    Colors.green,
                    () async {
                      Uri url = Uri.parse("tel:+91-$phone");
                      await launchUrl(url);
                    },
                  ),
                  _buildActionButton(
                    Icons.message,
                    "Message",
                    Colors.blue,
                    () async {
                      Uri url = Uri.parse("sms:$phone");
                      await launchUrl(url);
                    },
                  ),
                  _buildActionButton(
                    Icons.visibility_off,
                    "Hide",
                    Colors.grey,
                    () {
                      value.hideContacts(
                        name: name,
                        phone: phone,
                        email: email,
                      );
                    },
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex:
            Provider.of<BottomNavigationBarController>(context, listen: true)
                .index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
        onTap: (index) async {
          Provider.of<BottomNavigationBarController>(context, listen: false)
              .getBottomBarIndex(index: index);

          if (index == 0) {
            // Show delete bottom sheet
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Delete Contact",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Are you sure you want to delete this contact?",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Flexify.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            foregroundColor:
                                (Provider.of<ContactController>(context)
                                        .isTheme)
                                    ? Colors.white
                                    : Colors.black,
                          ),
                          child: const Text(
                            "Cancel",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<ContactController>(context,
                                    listen: false)
                                .deleteContact(
                              name: name,
                              phone: phone,
                              email: email,
                            )
                                .then((value) {
                              Flexify.goRemoveAll(HomePage(),
                                  animation: FlexifyRouteAnimations.blur,
                                  duration: Durations.medium1);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Delete"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (index == 2) {
            String contactInfo =
                "Contact Details:\nName: $name\nPhone: $phone\nEmail: $email";

            // await ShareExtend.share(contactInfo, "text");
            await Share.share(contactInfo);
          } else if (index == 1) {
            Flexify.goRemoveAll(
              EditContacts(
                name: name,
                phone: phone,
                email: email,
              ),
              animation: FlexifyRouteAnimations.blur,
              duration: Durations.medium1,
            );
          }
        },
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
