import 'package:contact_diary_app/controllers/theme_controller.dart';
import 'package:contact_diary_app/models/counter_model.dart';
import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:contact_diary_app/views/YourContact/your_contact.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:contact_diary_app/controllers/counter_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return ScreenUtilInit(
      designSize: Size(
        size.width,
        size.height,
      ),
      minTextAdapt: true,
      builder: (context, _) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => CounterController(
                CounterModel(
                  step: 1,
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => ThemeController(),
            ),
          ],
          child: Consumer<ThemeController>(
            builder: (context, themeController, _) {
              return Flexify(
                designWidth: size.width,
                designHeight: size.height,
                app: MaterialApp(
                  home: YourContact(),
                  debugShowCheckedModeBanner: false,
                  theme: themeController.isDarkMode
                      ? ThemeData.dark()
                      : ThemeData.light(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
