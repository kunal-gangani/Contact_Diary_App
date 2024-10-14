import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';

class DeletedContactsPage extends StatelessWidget {
  const DeletedContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trash",
        ),
        leading: IconButton(
          onPressed: () {
            Flexify.goRemove(
              const HomePage(),
              animation: FlexifyRouteAnimations.blur,
              duration: Durations.medium1,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
    );
  }
}
