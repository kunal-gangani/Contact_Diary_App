import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary_app/controllers/contact_controller.dart';

class EditContacts extends StatelessWidget {
  // Constructor to accept contact details
  final String name;
  final String phone;
  final String email;

  const EditContacts({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactController = Provider.of<ContactController>(context);

    // Initialize text controllers with the passed values
    final nameController = TextEditingController(text: name);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Contacts',
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
            ),
            onPressed: () {
              // Update user details using the modified values
              contactController.updateContactsDetails(
                name: name,
                phone: phone,
                email: email,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Details updated successfully!',
                  ),
                ),
              );

              // Navigate back to the home page
              Flexify.goRemoveAll(
                HomePage(),
                animation: FlexifyRouteAnimations.blur,
                duration: Durations.medium1,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
