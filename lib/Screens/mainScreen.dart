// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bridge/Screens/ScreenWidgets/userHome.dart';
import 'package:blood_bridge/Screens/ScreenWidgets/userProfile.dart';

import '../Widgets/BottomNavBar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  //const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    UserHome(),
    UserProfile(),
  ];

  static const TextStyle TitleStyle = TextStyle(color: Colors.white);

  static List<Widget> _widgetNames = <Widget>[
    Text(
      "Home",
      style: TitleStyle,
    ),
    Text(
      "Profile",
      style: TitleStyle,
    ),
  ];

  void _manageSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color.fromARGB(255, 217, 224, 230),
            Color(0xFF000A12),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: AppBar(
              backgroundColor: Colors.transparent,
              title: _widgetNames.elementAt(_selectedIndex)),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar:
            BottomNavBar(manageSelectedIndex: _manageSelectedIndex),
      ),
    );
  }
}
