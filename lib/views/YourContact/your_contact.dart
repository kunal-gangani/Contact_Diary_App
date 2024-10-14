import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary_app/controllers/theme_controller.dart';

class YourContact extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  YourContact({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Enter your Contact Details",
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image Picker
            GestureDetector(
              onTap: () async {
                // Pick an image
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  Fluttertoast.showToast(
                    msg: "Image selected: ${image.name}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Name Input
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              maxLength: 10,
              textInputAction: TextInputAction.done,
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Contact Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: () {
                final String name = nameController.text;
                final String contact = contactController.text;
                if (name.isEmpty || contact.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please enter all details",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Name: $name, Contact: $contact",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );

                  Flexify.goRemove(
                    const HomePage(),
                    animation: FlexifyRouteAnimations.blur,
                    duration: Durations.medium1,
                  );
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
