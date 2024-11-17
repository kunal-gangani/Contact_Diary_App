import 'package:contact_diary_app/controllers/bottom_navaigation_bar_controller.dart';
import 'package:contact_diary_app/controllers/contact_controller.dart';
import 'package:contact_diary_app/main.dart';
import 'package:contact_diary_app/models/contacts_model.dart';
import 'package:contact_diary_app/views/SplashScreen/splash_screen.dart';
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
              create: (_) => ContactController(
                contactsModel: ContactsModel(
                  phoneList: phoneList,
                  nameList: nameList,
                  emailList: emailList,
                  isTheme: isTheme ?? false, // default to false if null
                  userName: userName ?? '', // default to empty if null
                  userPhone: userPhone ?? '', // default to empty if null
                ),
              ),
            ),
            ChangeNotifierProvider(
              create: (_) => BottomNavigationBarController(),
            )
          ],
          child: Consumer<ContactController>(
            builder: (context, value, _) {
              return Flexify(
                designWidth: size.width,
                designHeight: size.height,
                app: MaterialApp(
                  home: const SplashScreen(),
                  debugShowCheckedModeBanner: false,
                  theme: value.isTheme ? ThemeData.dark() : ThemeData.light(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
