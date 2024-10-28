import 'package:contact_diary_app/controllers/bottom_navaigation_bar_controller.dart';
import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/controllers/theme_controller.dart';
import 'package:contact_diary_app/main.dart';
import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:contact_diary_app/views/HomePage/home_page.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
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
              create: (_) => ThemeController(this),
            ),
            ChangeNotifierProvider(
              create: (_) => ContactController(
                contactsModel: ContactsModel(
                  phoneList: phoneList,
                  nameList: nameList,
                  emailList: emailList,
                  isTheme: false,
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => BottomNavaigationBarController(),
            )
          ],
          child: Consumer<ThemeController>(
            builder: (context, themeController, _) {
              return Flexify(
                designWidth: size.width,
                designHeight: size.height,
                app: MaterialApp(
                  home: const HomePage(),
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
