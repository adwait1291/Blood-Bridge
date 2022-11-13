// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final Function manageSelectedIndex;
  BottomNavBar({required this.manageSelectedIndex});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.h),
            color: Color(0xFFF15F79),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              backgroundColor: Color(0xFFF15F79),
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor:
                  Color.fromARGB(255, 157, 67, 84), //Colors.blueGrey,
              haptic: true, // haptic feedback
              tabBorderRadius: 40.r,
              curve: Curves.easeInOutCubic, // tab animation curves
              iconSize: 25.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),

              tabs: [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(icon: Icons.person, text: "Profile"),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  widget.manageSelectedIndex(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
