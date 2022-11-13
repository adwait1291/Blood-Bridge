// ignore_for_file: file_names, prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blood_bridge/Screens/ScreenWidgets/userHome.dart';
import 'package:blood_bridge/Screens/ScreenWidgets/userProfile.dart';

import '../Widgets/BottomNavBar.dart';

class MainScreen extends StatefulWidget {
  final User user;
  MainScreen({required this.user});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _manageSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle TitleStyle = TextStyle(
        color: Color(0xFFA50D41), fontSize: 25, fontWeight: FontWeight.bold);

    List<String> TextList = ["Hi, ${widget.user.displayName}!", "Profile"];
    List<Widget> _widgetOptions = <Widget>[
      UserHome(),
      UserProfile(
        user: widget.user,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: AppBar(
            centerTitle: _selectedIndex == 1,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            leadingWidth: 0,
            toolbarHeight: 100.h,
            title: Column(
              children: [
                SizedBox(height: 15.h),
                Text(
                  TextList[_selectedIndex],
                  style: TitleStyle,
                ),
              ],
            ),
            elevation: 0.8,
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar:
            BottomNavBar(manageSelectedIndex: _manageSelectedIndex),
      ),
    );
  }
}
