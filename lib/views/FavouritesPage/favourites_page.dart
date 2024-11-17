import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Flexify.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: Colors.orange,
        elevation: 4,
        title: const Text(
          'Favourites',
        ),
      ),
      body: Consumer<ContactController>(
        builder: (context, value, _) {
          return value.contactsModel.favNameList.isEmpty
              ? const Center(
                  child: Text(
                    'No favorites added.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: value.contactsModel.favNameList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shadowColor: (value.contactsModel.isTheme)
                          ? Colors.black
                          : Colors.grey,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Text(
                            value.contactsModel.favNameList[index][0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          value.contactsModel.favNameList[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone: ${value.contactsModel.favPhoneList[index]}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Email: ${value.contactsModel.favEmailList[index]}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                          ),
                          onPressed: () {},
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
