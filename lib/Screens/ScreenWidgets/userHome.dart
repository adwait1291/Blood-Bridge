// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 130.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 187, 186, 186),
                            blurRadius: 2.r,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            'assets/images/mainScreenImage.png',
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Please select donate or receive to see the options.",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: 130.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 187, 186, 186),
                            blurRadius: 2.r,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            'assets/images/mainScreenImage2.png',
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Donation centre details will be shown here.",
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
