import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HiddenContacts extends StatelessWidget {
  const HiddenContacts({super.key});

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
              animation: FlexifyRouteAnimations.blur,
              duration: Durations.medium1,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Hidden Contacts",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<ContactController>(
        builder: (context, value, _) {
          return (value.contactsModel.hiddenEmailList.isEmpty)
              ? Center(
                  child: Text(
                    "No Hidden Contacts",
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: value.contactsModel.hiddenEmailList.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final contactName =
                        value.contactsModel.hiddenNameList[index];
                    final contactPhone =
                        value.contactsModel.hiddenPhoneList[index];

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 25,
                          child: Text(
                            contactName[0],
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          contactName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          contactPhone,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.visibility_off,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
