import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class AddContacts extends StatelessWidget {
  const AddContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          ),
        ),
        title: const Text(
          'Add Contact',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            _buildTextField(
              hintText: "Name",
              icon: Icons.person_outline,
              controller: nameController,
            ),
            SizedBox(
              height: 20.h,
            ),
            _buildTextField(
              hintText: "Phone Number",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              controller: phoneController,
              maxLength: 10,
            ),
            SizedBox(
              height: 20.h,
            ),
            _buildTextField(
              hintText: "Email",
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<ContactController>(context, listen: false)
                      .addContactData(
                    name: nameController.text,
                    phone: phoneController.text.trim(),
                    email: emailController.text.trim(),
                  )
                      .then(
                    (value) {
                      nameController.clear();
                      phoneController.clear();
                      emailController.clear();
                      Flexify.back();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 14.h,
                    horizontal: 60.w,
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    int? maxLength,
  }) {
    return TextField(
      maxLength: maxLength,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 18.h,
          horizontal: 16.w,
        ),
      ),
      style: const TextStyle(
        color: Colors.black87,
      ),
    );
  }
}
