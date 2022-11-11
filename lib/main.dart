import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Auth/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
            title: 'Mess',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // routes: {
            //   Profile.routeName: (ctx) => Profile(),
            // },
            home: LoginPage());
      },
    );
  }
}
