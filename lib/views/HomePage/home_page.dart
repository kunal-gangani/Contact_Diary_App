import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary_app/controllers/counter_controller.dart';
import 'package:contact_diary_app/controllers/theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the CounterController instance from the provider
    final counterController = Provider.of<CounterController>(context);
    final themeController =
        Provider.of<ThemeController>(context); // Access the ThemeController

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Contacts",
          style: TextStyle(
            fontSize: 22.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeController.changeTheme();
            },
            icon: Icon(
              themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Krishna",
              style: TextStyle(
                fontSize: 24.sp,
              ),
            ),
            subtitle: Text(
              "College",
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          // Display the current counter value
          Text(
            "Counter Value: ${counterController.counter}",
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 20.h), // Add spacing

          // Buttons to increment and decrement the counter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Call the increment method from CounterController
                  counterController.increment();
                },
                child: const Text("Increment"),
              ),
              SizedBox(
                width: 10.w,
              ), // Add spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Call the decrement method from CounterController
                  counterController.decrement();
                },
                child: const Text("Decrement"),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can also increment the counter using the floating action button
          counterController.increment();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
